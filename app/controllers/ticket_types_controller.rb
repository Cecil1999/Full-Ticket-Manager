class TicketTypesController < ApplicationController
  def create
  end

  def destory
  end

  private
  def ticket_type_params
    params.expect(ticket_type: [ :name ])
  end
end
