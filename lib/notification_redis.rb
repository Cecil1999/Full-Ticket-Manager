module NotificationRedis
  # For edge cases that may be developed later that require the need to get the notifications of another user.
  @redis = Redis.new(host: "127.0.0.1", port: 6379)
  def get(user = $current_user)
  end

  def set(notification)
  end
end
