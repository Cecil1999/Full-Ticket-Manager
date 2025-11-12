class AuthController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_user_not_found

  def create
    @user = User.find_by!(username: params[:username])

    if !@user.enabled
      render json: { e: "Contact Administrator." }, status: 403
    end

    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(id: @user.id)
      render json: { r: "success", auth_token: token }
    else
      handle_bad_authentication
    end
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
    @token = request.headers["Authorization"].split(" ").last
    decoded_token = JsonWebToken.decode(@token)
    BlacklistRedis.add(decoded_token)
  end
end
