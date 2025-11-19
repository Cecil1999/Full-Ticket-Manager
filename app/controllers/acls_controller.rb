class AclsController < ApplicationController
  include Authenticable
  include Authorizable

  before_action :acl_params
  before_action :get_acl

  # GET /acl/:ctrl/(:act)?
  def show
    render json: { r: @acl.as_json(include: { roles: { only: :name } }) }
  end

  # DELETE /acl/:ctrl/(:act)?
  def destroy
    @acl.all.each do |acl_entry|
      acl_entry.roles.clear
      acl_entry.enabled = false
      acl_entry.save!
    end

    render json: { r: "acl entry destroyed" }
  end

  private
  def acl_params
    params.expect(:ctrl)
  end

  def get_acl
    acl_hash = params[:act] ? { controller: params[:ctrl], action: params[:act] } : { controller: params[:ctrl] }

    @acl = Acl.where(acl_hash)
  end
end
