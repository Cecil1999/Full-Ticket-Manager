class AddEnabledColToTeam < ActiveRecord::Migration[8.1]
  def change
    add_column :teams, :enabled, :boolean, default: true
  end
end
