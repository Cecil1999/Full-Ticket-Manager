class CreateTicketTemplateTable < ActiveRecord::Migration[8.1]
  def change
    create_table :ticket_templates do |t|
      t.text :template, null: false
      # t.jsonb :data, null: false, default: '{"description":"textarea"}'
    end

    add_reference :ticket_templates, :ticket_type, null: false, foreign_key: true
  end
end
