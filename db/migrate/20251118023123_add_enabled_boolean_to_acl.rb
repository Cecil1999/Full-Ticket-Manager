class AddEnabledBooleanToAcl < ActiveRecord::Migration[8.1]
  def change
    add_column :acls, :enabled, :boolean, default: true
  end
end
