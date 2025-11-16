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

    # TODO once feature is added, need to get a list of 'features' that the role still has authorization to use.
    # Honestly should probably do that with users too.
    render json: { r: "Role successfully deleted." }
  end

  def update
    # TODO figure out if its 'Acceptable' to edit the name of a role. or if this route is even necessary.
    if @role.update()
      render json: { r: "Role updated" } 
    else
      render json: { e: role.errors }, status: 422
    end
  end

  private 
  def role_params
    params.expect(role: [ :name, :enabled ])
  end 

  def set_role 
    @role = Role.find(params[:id])
  end
end
