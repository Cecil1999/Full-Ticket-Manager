class Api::V1::TicketsController < Api::V1::ApplicationController
  include Authenticable

  before_action :ticket_params, only: %i[ update create ]
  before_action :set_ticket, only: %i[ show update ]

  def index
    render json: { r: Ticket.all.order(created_at: :desc).limit(100).as_json() }
  end

  def show
    render json: { r: @ticket.as_json({ posts: {} }) }
  end

  def update
    if @ticket.update(ticket_params)
      if @ticket.user_id != $current_user.id
        notification = Notification.create(
          title: "Ticket ID: #{@ticket.id} has been updated by #{current_user.username}",
          body: "Ticket ID: has been updated.",
        )

        notification.user_id = @ticket.user_id

        notification.save!
      end
      render json: { r: "Ticket Updated." }
    else
      render json: { e: @ticket.errors }, status: 422
    end
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.user_id = $current_user.id

    if @ticket.save
      render json: { r: "Ticket Created" }
    else
      render json: { e: @ticket.errors }, status: 422
    end
  end

  def destroy
    render json: { e: "Hey bad boi this ain't ready yet." }, status: 403
  end

  private
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.expect(ticket: [ :title, :body, :ticket_type_id ])
  end
end
