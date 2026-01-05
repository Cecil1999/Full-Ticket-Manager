class AddTicketTypeIdToTickets < ActiveRecord::Migration[8.1]
  def change
    add_reference :tickets, :ticket_types
  end
end
