class CreateAcls < ActiveRecord::Migration[8.1]
  def change
    create_table :acls do |t|
      t.string :controller, null: false
      t.string :action, null: false

      t.timestamps
    end

    create_table :acls_roles, id: false do |t|
      t.belongs_to :acl
      t.belongs_to :role
    end

    add_foreign_key :acls_roles, :acls
    add_foreign_key :acls_roles, :role
