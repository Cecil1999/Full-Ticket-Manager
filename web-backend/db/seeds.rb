# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

[ 'fibre', 'cable' ].each do | type_name |
  TicketType.find_or_create_by!(name: type_name)
end

[ 'title1', 'title2' ].each do |title|
  Ticket.find_or_create_by!(title: title, body: 'Seed Data Destory', ticket_type_id: 2, user_id: 1)
end

[ 'User', 'Admin' ].each do |role|
  Role.find_or_create_by!(name: role)
end
