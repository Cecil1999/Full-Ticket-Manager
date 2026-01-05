class RenameTicketTypesIdtoTicketTypeIdInTickets < ActiveRecord::Migration[8.1]
  def change
    rename_column :tickets, :ticket_types_id, :ticket_type_id
  end
end
