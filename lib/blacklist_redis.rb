module BlacklistRedis
  @redis = Redis.new(host: "127.0.0.1", port: 6379, db: 1)

  def self.add(token)
    @redis.setex("blacklist:jid:#{token["jid"]}", 24.hours.to_i, "logged_out")
  end

  def self.check(token)
    raise Authenticable::BlackListedJWTTokenSpotted if @redis.get("blacklist:jid:#{token["jid"]}")
  end
end
