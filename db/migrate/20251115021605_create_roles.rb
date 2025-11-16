class CreateRoles < ActiveRecord::Migration[8.1]
  def change
    create_table :roles do |t|
      t.string :name
    end

    create_table :user_roles, id: false do |t|
      t.belongs_to :user
      t.belongs_to :role
    end

    add_index :roles, :name, unique: true
    add_foreign_key :user_roles, :users 
    add_foreign_key :user_roles, :roles 
  end
end
