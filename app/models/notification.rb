class Notification < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true

  # Only caller should be our crontab job. We could have this in a route as well.
  # Get all notifications from DB. Update them in the cache, have to do this for each 'user'.
  # O(n^2) time, that's why we really shouldn't be storing more then 50 notifications for each person.
  def orcish_notificatons
    redis_notification = NotificationRedis

    notifications = Notification.where.not(seen).order(:user_id, created_at: DESC).limit(25)

    return unless notifications.length

    notifications.each do |notification|
      redis_notification.set_notification("notification:#{notification.user_id}", notification.as_json)

      notification.seen = true
      notification.save
    end
  end


  # Only caller should be our crontab job. We should have this in some sort of route.
  # Lists should be <= {25} (TODO: figure out some RoR variable for this.),
  # due to our limit. Check to ensure our notification lists ARE infact <= 25. If not pop <length> - 25.
  def clean_orcish_notification_list
    redis_notification = NotificationRedis
    User.all() do |user|
      current_length = redis_notification.notification_by_user(user.id)

      next if current_length <= 25

      redis_notification.trim_notifications_by_user(user.id)
    end
  end
end
