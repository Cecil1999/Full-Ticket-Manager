module NotificationRedis
  @redis = Redis.new(host: "127.0.0.1", port: 6379)

  class << self
    def unseen_notifications(user_id = $current_user.id)
      @redis.lrange("notifications:#{user_id}", 0, -1)
        .map! { |n| JSON.parse(n) }
    end

    def get_all_notifications(user_id = $current_user.id)
      all_notifications = @redis.lrange("notifications:#{user_id}", 0, -1)
      all_notifications.map! { |notification| JSON.parse(notification) }
    end

    def set_notification(user_id, notification)
      @redis.lpush("notifications:#{user_id}", notification.to_json)
    end

    def notifications_by_user(user_id)
      @redis.llen("notifications:#{user_id}")
    end

    def trim_user_notifications_list(user_id, count)
      nil unless count

      @redis.rpop("notifications:#{user_id}", count)
    end
  end
end
