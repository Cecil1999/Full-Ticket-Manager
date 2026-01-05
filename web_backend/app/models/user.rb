class User < ApplicationRecord
  has_secure_password
  has_and_belongs_to_many :roles
  belongs_to :team, optional: true
  has_many :notifications
  has_many :posts
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  def create_access_token
    JsonWebToken.encode_access_token(id: self.id)
  end

  def create_refresh_token
    token = JsonWebToken.create_refresh_token(id: self.id)
    self.refresh_token = token
    self.save!
    token
  end
end
