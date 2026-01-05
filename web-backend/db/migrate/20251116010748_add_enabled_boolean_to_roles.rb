class AddEnabledBooleanToRoles < ActiveRecord::Migration[8.1]
  def change
    add_column :roles, :enabled, :boolean, default: true
  end
end
