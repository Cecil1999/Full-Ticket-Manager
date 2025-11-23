class TicketType < ApplicationRecord
  has_many :tickets
  has_one :ticket_template
end
