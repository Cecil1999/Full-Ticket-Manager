class Notification < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true

  def orcish_notificatons
    NotificationRedis.get()
  end
end
