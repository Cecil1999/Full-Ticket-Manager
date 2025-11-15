class User < ApplicationRecord
  has_secure_password
  belongs_to_and_has_many :role
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
end
