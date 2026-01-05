class CreateTicketTypes < ActiveRecord::Migration[8.1]
  def change
    create_table :ticket_types do |t|
      t.string :name
      t.boolean :enabled, null: false
    end
  end
end
