class TicketsController < ApplicationController
    include Authenticable

    before_action :ticket_params, only: %i[ update create ]
    before_action :set_ticket, only: %i[ show update ]
    before_action :ticket_type_hash, only: %i[ index show update create ]

    def index
      render json: { r: [ tickets: Ticket.all.order(created_at: :desc).limit(100), ticket_types: @ticket_type_hash ] }
    end

    def show
      render json: @ticket, include: { posts: {}, ticket_type: { only: :name } }
    end

    def update
        if @ticket.update(ticket_params)
            render json: { r: "Ticket Updated." }
        else
            render json: { e: @ticket.errors }, status: 422
        end
    end

    def create
        @ticket = Ticket.new(ticket_params)

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

    def ticket_type_hash
      @ticket_type_hash = TicketType.all.map { |type| [ type.id, type.name ] }.to_h
    end
end
