class AddDefaultTrueToTicketsEnabled < ActiveRecord::Migration[8.1]
  def change
    change_column_default(:ticket_types, :enabled, 'TRUE')
  end
end
