class CreateNotifications < ActiveRecord::Migration[8.1]
  def change
    create_table :notifications do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.boolean :seen, null: false
      t.datetime :created_at, null: false, default: -> { 'NOW()' }
    end
  end
end
