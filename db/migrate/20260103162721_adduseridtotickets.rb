class Adduseridtotickets < ActiveRecord::Migration[8.1]
  def change
    add_reference :tickets, :user, null: false, foreign_key: true
  end
end
