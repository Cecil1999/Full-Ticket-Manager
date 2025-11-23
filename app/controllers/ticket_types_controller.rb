class TicketTypesController < ApplicationController
  include Authenticable
  before_action :set_ticket_type, only: %i[ show destroy update ]

  def index
    render json: { r: TicketType.all.as_json(include: { ticket_template: { only: :template } }) }
  end

  def create
    @type = TicketType.create(ticket_type_params)
    @type.build_ticket_template(template: params[:template]) if params[:template]

    if @type.save
      render json: { r: "Ticket Type successfully created." }
    else
      render json: { e: @type.errors }, status: 422
    end
  end

  def show
    render json: { r: @type.as_json(include: { ticket_template: { only: :template } }) }
  end

  def update
    if params[:name]
      render json: { e: "Cannot change anything other then the Template." }, status: 422 and return
    end
    puts params[:template]
    if @type.ticket_template.update(template: params[:template])

      render json: { r: "Ticket Type updated." } and return
    else
      render json: { e: @type.errors }, status: 422 and return
    end
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
  def set_ticket_type
    @type = TicketType.find(params[:id])
  end

  def ticket_type_params
    params.expect(ticket_type: [ :name ])
  end
end
