class AddTicketIdtoPosts < ActiveRecord::Migration[8.1]
  def change
    add_reference :posts, :ticket
  end
end
