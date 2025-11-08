class TicketTypesController < ApplicationController
  before_action :set_ticket_type, only: %i[ show destroy ]

  def index
    render json: { r: TicketType.all }
  end

  def create
    @type = TicketType.create(ticket_type_params)

    if @type.save
      render json: { r: "Ticket Type Succesfully Created." }
    else
      render json: { e: @type.errors }, status: 422
    end
  end

  def show
    render json: { r: @type }
  end

  def update
    render json: { e: "Action Forbidden" }, status: 403
  end

  def destroy
    @type.enabled = "FALSE"

    if @type.save
      render json: { r: "Post Successfully Deleted" }
    else
      render json: { e: @type.errors }, status: 422
    end
  end

  private
  def set_type_type
    @type = TicketType.find(params[:id])
  end

  def ticket_type_params
    params.expect(ticket_type: [ :name ])
  end
end
