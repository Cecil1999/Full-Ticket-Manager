class Api::V1::AuthController < Api::V1::ApplicationController
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
      user.create_refresh_token

      response.set_cookie(:refresh_token, {
        value: user.refresh_token,
        httponly: true,
        secure: true,
        path: "/api/v1/refresh_token",
        expires: 1.hour.from_now
      })

      render json: { r: "success", auth_token: user.create_access_token() }
    else
      handle_bad_authentication
    end
  end

  def refresh
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
