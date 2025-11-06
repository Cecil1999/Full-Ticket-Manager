class TicketsController < ApplicationController
    before_action :ticket_params, only: %i[ update create ]
    before_action :set_ticket, only: %i[ show update ]

    def index
        render json: Ticket.all
    end

    def show
        render json: @ticket
    end

    def update
        if @ticket.update
            render json: { r => "Ticket Updated." }
        else
            render json: { e => @ticket.errors }, status: :unprocessable_entity
        end
    end

    def create
        @ticket = Ticket.new(ticket_params)

        if @ticket.save
            render json: { r: "Ticket Created" }
        else
            render json: { e: @ticket.errors }, status: :unprocessable_entity
        end
    end

    def destroy
        render json: { e: "Hey bad boi this ain't ready yet." }, :status => 403
    end

    private
    def set_ticket()
        @ticket = Ticket.find(params[:id])
    end

    def ticket_params()
        params.expect(ticket: [:title, :body])
    end
end
