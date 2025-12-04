class Ticket < ApplicationRecord
    validates :title, presence: true
    validates :body, presence: true
    belongs_to :ticket_type
    has_many :posts

    def as_json(include_options = {}, other_options = {})
      include_options = include_options.merge(
        ticket_type: { only: :name }
      )

      super(
        include: include_options
      )
    end
end
