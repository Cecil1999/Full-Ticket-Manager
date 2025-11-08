class AddFKforAllReferences < ActiveRecord::Migration[8.1]
  def change
    add_foreign_key :posts, :tickets
    add_foreign_key :tickets, :ticket_types
  end
end
