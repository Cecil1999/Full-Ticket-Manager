module NotificationRedis
  @redis = Redis.new(host: "127.0.0.1", port: 6379)

  class << self
    def unseen_notifications(user_id = $current_user.id)
      all_notifications = all_cached_notifications

      unseen = all_notifications.select do |notification|
        notification["seen_by_user"] == false
      end

      update_notifications_seen_by_user(all_notifications, user_id)

      unseen
    end

    def get_all_notifications(user_id = $current_user.id)
      all_notifications = all_cached_notifications(user_id)
      update_notifications_seen_by_user(all_notifications, user_id)
      all_notifications
    end

    def set_notification(user_id, notification)
      @redis.call("DEL", "notifications:#{user_id}")
      @redis.set("notifications:#{user_id}", notification.to_json)
    end

    private
    def all_cached_notifications(user_id = $current_user.id)
      notificationJson = @redis.get("notifications:#{user_id}")
      return unless notificationJson
      JSON.parse(notificationJson)
    end

    def update_notifications_seen_by_user(all_notifications, user_id = $current_user.id)
      all_notifications ||= all_cached_notifications

      all_notifications.each do |n|
        n["seen_by_user"] = true
      end

      @redis.set("notifications:#{user_id}", all_notifications.to_json)
    end
  end
end
