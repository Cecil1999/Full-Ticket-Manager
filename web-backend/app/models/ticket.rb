class Ticket < ApplicationRecord
    validates :title, presence: true
    validates :body, presence: true
    belongs_to :ticket_type
    belongs_to :user
    has_many :posts

    def as_json(include_options = {}, other_options = {})
      default_includes = {
        ticket_type: { only: :name }
      }

      merged_includes = default_includes.deep_merge(include_options)

      super(
        include: merged_includes
      )
    end
end
