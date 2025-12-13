class Api::V1::AuthController < Api::V1::ApplicationController
  include ActionController::Cookies

  rescue_from ActiveRecord::RecordNotFound, with: :handle_user_not_found

  def create
    if request.headers["Authorization"]
      render json: { r: check_token? } and return
    end

    user = User.find_by!(username: params[:username])

    if !user.enabled
      render json: { e: "Contact Administrator." }, status: 403
    end

    if user&.authenticate(params[:password])
      response.set_cookie(:refresh_token, {
        value: user.create_refresh_token,
        httponly: true,
        secure: true,
        path: "/api/v1/auth/refresh_token",
        expires: 1.day.from_now
      })

      render json: { r: "success", auth_token: user.create_access_token() }
    else
      handle_bad_authentication
    end
  end

  # GET /auth/refresh_token
  def refresh
    token = JsonWebToken.decode_refresh_token(cookies[:refresh_token])

    if token["type"] != "refresh"
      # TODO: Maybe "Log" this instead of returning this don't really want to tell the users that we know it isn't a refresh token.
      render json: { e: "Cannot use access, nor any other type as a refresh token." }, status: 404 and return
    end

    user = User.find(token["id"])

    render json: { r: "success", auth_token: user.create_access_token() }
  end

  def destroy
    revoke_token
  end

  private
  def sign_in_params
    params.expect(user: [ :username, :password ])
  end

  def handle_bad_authentication
    render json: { e: "Username and/or password do not match out records." }, status: 404
  end

  def handle_user_not_found
    render json: { e: "Username and/or password do not match our records." }, status: 404
  end

  def revoke_token
    token = request.headers["Authorization"].split(" ").last
    decoded_token = JsonWebToken.decode(token)
    BlacklistRedis.add(decoded_token)
  end

  def check_token?
    token = request.headers["Authorization"].split(" ").last
    decoded_token = JsonWebToken.decode(token)
    !!decoded_token
  end
end
