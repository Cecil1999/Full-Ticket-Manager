class RolesController < ApplicationController
  include Authenticable

  before_action :set_role, only: %i[ show update destroy ]

  def index
    render json: { r: "Unable to see all roles." }, status: 403
  end

  def show
    render json: { r: @role.as_json(only: [ :name, :enabled ]) }
  end

  def create
    new_role = Role.new(role_params)

    if new_role.save
      render json: { r: "Role successfully created." }
    else
      render json: { e: new_role.errors }, status: 422
    end
  end

  def destroy
    @role.enabled = false
    @role.save!

    render json: { r: "Role successfully deleted." }
  end

  # PATCH/PUT /roles/:id, route is forbidden, if you need a new role. Just create a new one.
  def update
    render json: { e: "Forbidden" }, status: 403
  end

  private
  def role_params
    params.expect(role: [ :name, :enabled ])
  end

  def set_role
    @role = Role.find(params[:id])
  end
end
