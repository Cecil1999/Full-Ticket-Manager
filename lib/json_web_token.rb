require_relative "blacklist_redis"

module JsonWebToken
  # Need to figure out a good way to 'Store' secret_key for the signature. For now.... just use the test Key.
  @hmac_secret = "kWnVtZA2LezioE6c9TvP0ZRyT7mydZLKG49MafhX9GE="
  # Self Encoding
  def self.encode(payload, exp = 24.hours.to_i)
    payload[:exp] = Time.now.to_i + exp
    payload[:jid] = ActiveRecord::Base.connection.exec_query("SELECT nextval('jwt_id_sequence')").to_a.first["nextval"]
    JWT.encode(payload, @hmac_secret, "HS256")
  end

  # Self Decode
  def self.decode(token)
    decoded_token = JWT.decode(token, @hmac_secret, true, { algorithm: "HS256" }).first
    BlacklistRedis.check(decoded_token)
  end
end
