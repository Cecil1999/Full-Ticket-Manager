class User < ApplicationRecord
  has_secure_password
  has_and_belongs_to_many :role
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
end
