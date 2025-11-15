class Role < ApplicationRecord
  belongs_to_and_has_many :user
end
