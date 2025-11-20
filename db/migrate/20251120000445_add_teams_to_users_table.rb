class AddTeamsToUsersTable < ActiveRecord::Migration[8.1]
  def change
    add_reference :users, :team, index: true, foreign_key: true
  end
end
