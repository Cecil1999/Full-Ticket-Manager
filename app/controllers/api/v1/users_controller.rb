class Api::V1::UsersController < Api::V1::ApplicationController
  include Authenticable
  include Authorizable

  def profile
    render json: { r: $current_user.as_json(only: [ :id, :username, :email ], include: { roles: { only: :name }, team: { only: :name } }) }
  end

  def update
    if $current_user.update(user_params)
      render json: { r: "User Updated." }
    else
      render json: { e: $current_user.errors }, status: 422
    end
  end

  private
  def user_params
    params.permit(:username, :email)
  end
end
