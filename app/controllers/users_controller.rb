class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  def index
    render json: { e: "Cannot see all users." }, status: 403
  end

  def show
    render json: { r: @user.as_json(only: [ :id, :username, :email ]) }
  end

  def create
    render json: { e: "Forbidden." }, status: 403
=begin
    @user = User.create(user_params)

    if @user.save
      render json: { r: "User created." }
    else
      render json: { e: @user.errors }, status: 403
    end
=end
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
=begin
    @user.enabled = "FALSE"

    if @user.save
      render json: { r: "User deleted. " }
    else
      render json: { e: @user.errors }, status: 403
    end
=end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.expect(user: [ :username, :email, :password_digest, :password_confirmation ])
  end
end
