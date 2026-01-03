class AddSeenDefaultToFalse < ActiveRecord::Migration[8.1]
  def change
    change_column_default(:notifications, :seen, :false)
  end
end
