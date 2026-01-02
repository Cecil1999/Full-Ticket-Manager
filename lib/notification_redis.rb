module NotificationRedis
  # For edge cases that may be developed later that require the need to get the notifications of another user.
  @redis = Redis.new(host: "127.0.0.1", port: 6379)
  def get_all_notification(user_id = $current_user.id)
    @redis.lrange(0, -1)
  end

  def set_notification(user_id = $current_user.id, notification)
    @redis.lpush("notifications:#{user_id}", notification)
  end

  def notifications_by_user(user_id = $current_user.id)
    @redis.llen("notifications:#{user_id}")
  end

  def trim_user_notification_list(user_id = $current_user.id, count)
    nil unless count

    @redis.lpop("notifications:#{user_id}", count)
  end
end
