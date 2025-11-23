class TicketType < ApplicationRecord
  has_many :tickets
  has_many :ticket_templates
end
