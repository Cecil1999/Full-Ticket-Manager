class TicketsController < ApplicationController
    before_action :set_ticket, only: %i[ show edit ]

    def index
        render json: Ticket.all
    end

    def show
        render json: @ticket
    end

    def update
    end

    def create
    end

    def destory
    end

    private
    def set_ticket()
        @ticket = Ticket.find(params[:id])
    end
end
