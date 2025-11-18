class AclsController < ApplicationController
  include Authenticable

  def show
    params.expect!(:ctrl)
    rescue ActionController::ExpectedParameterMissing => e
      render json: { e: "Expected Controller" }, status: 422 and return


    if params[:action]
      render json: { r: ACL.find_by(controller: params[:ctrl], action: params[:act])}
    else
      render json: { r: ACL.find_by(controller: params[:ctrl])}
    end

  end

  def update
  end
end
