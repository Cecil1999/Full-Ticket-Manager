class Notification < ApplicationRecord
  attribute :seen_by_user, :boolean
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true

  class << self
    def get
      NotificationRedis.get_all_notifications()
    end

    def get_unseen
      NotificationRedis.unseen_notifications()
    end

    def orcish_notification
      new_notifications = Notification.where.not(seen: true).order(:id, :user_id, created_at: :desc).limit(25)
      return unless new_notifications.any?

      user_x_notifications = new_notifications.group_by(&:user_id)

      redis_notification = NotificationRedis
      user_x_notifications.each_key do |user_id|
        cached_notifications = redis_notification.get_all_notifications(user_id)

        cache_ready_notifications = user_x_notifications[user_id].map do |notification|
          notification.seen_by_user = false
          notification
        end

        # DB itself should never know that a user has seen a cached notification, as this would defeat the purpose of using it.
        combined_notifications = ((cache_ready_notifications || []) + (cached_notifications || []))
          .inject({}) { |hash, item| hash[item["id"]] = item; hash }.sort_by { |k, v| k }.to_h.values.reverse

        combined_notifications.first(25)

        redis_notification.set_notification(user_id, combined_notifications)

        user_x_notifications[user_id].each { |n| n.update(seen: true) }
      end
    end
  end
end
