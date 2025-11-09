class AuthController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_user_not_found

  def create
    @user = User.find_by!(username: params[:username])

    if !@user.enabled
      # logger.fatal "#{user.username} is disabled"
      render json: { e: "Contact Administrator." }, status: 404
    end

    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(id: @user.id)
      render json: { r: "success", auth_token: token }
    else
      handle_bad_authentication
    end
  end

  def destroy
  end

  private
  def sign_in_params
    params.expect(user: [ :username, :password ])
  end

  def handle_bad_authentication
    render json: { e: "Username and/or password do not match out records." }, status: 404
  end

  def handle_user_not_found
    # logger.fatal "#{params[user.username]} recorded as NOT FOUND"
    render json: { e: "Username and/or password do not match our records." }, status: 404
  end

end
