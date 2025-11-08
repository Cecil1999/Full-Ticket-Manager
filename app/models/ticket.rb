class Ticket < ApplicationRecord
    validates :title, presence: true
    validates :body, presence: true
    belongs_to :ticket_type
    has_many :posts
end
