class RenameUserRolesTable < ActiveRecord::Migration[8.1]
  def change
    rename_table :user_roles, :roles_users
  end
end
