class Notification < ApplicationRecord
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

    # Only caller should be our crontab job. We could have this in a route as well.
    # Get all notifications from DB. Update them in the cache, have to do this for each 'user'.
    # O(n^2) time, that's why we really shouldn't be storing more then 50 notifications for each person.
    def orcish_notification
      redis_notification = NotificationRedis

      notifications = Notification.where.not(seen: true).order(:id, :user_id, created_at: :desc).limit(25)

      return unless notifications.any?

      notifications.each do |notification|
        redis_notification.set_notification(notification.user_id, notification)

        notification.seen = true
        notification.save!
      end
    end

    # Only caller should be our crontab job. We should have this in some sort of route.
    # Lists should be <= {25} (TODO: figure out some RoR variable for this.),
    # due to our limit. Check to ensure our notification lists ARE infact <= 25. If not pop <length> - 25.
    def clean_orcish_notification_list
      redis_notification = NotificationRedis
      users = User.all
      users.each do |user|
        current_length = redis_notification.notifications_by_user(user.id)

        puts current_length

        next if current_length <= 25

        redis_notification.trim_user_notifications_list(user.id, current_length - 25)
      end
    end
  end
end
