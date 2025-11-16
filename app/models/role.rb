class Role < ApplicationRecord
  has_and_belongs_to_many :user
  validates :name, presence: true, uniqueness: true
end
