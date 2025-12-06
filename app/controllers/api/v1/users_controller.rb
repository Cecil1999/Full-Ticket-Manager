class Api::V1::UsersController < Api::V1::ApplicationController
  include Authenticable
  include Authorizable

  before_action :set_user, only: %i[ show update destroy ]

  def index
    render json: { e: "Cannot see all users." }, status: 403
  end

  def show
    render json: { r: @user.as_json(only: [ :id, :username, :email ], include: { roles: { only: :name }, team: { only: :name } }) }
  end

  def profile
    render json: { r: $current_user.as_json(only: [ :id, :username, :email ], include: { roles: { only: :name }, team: { only: :name } }) }
  end

  def create
    render json: { e: "Forbidden." }, status: 403
  end


  def update
    if @user.update(user_params)
      render json: { r: "User Updated." }
    else
      render json: { e: @user.errors }, status: 422
    end
  end

  def destroy
    render json: { e: "Forbidden." }, status: 403
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.expect(user: [ :username, :email, :password, :password_confirmation, :team_id, role_ids: [] ])
  end
end
