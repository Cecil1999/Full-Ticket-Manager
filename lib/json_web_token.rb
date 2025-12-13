require_relative "blacklist_redis"

module JsonWebToken
  # Need to figure out a good way to 'Store' secret_key for the signature. For now.... just use the test Key.
  @access_token_secret  = "kWnVtZA2LezioE6c9TvP0ZRyT7mydZLKG49MafhX9GE="
  @refresh_token_secret = "test12345678910"

  def self.encode_access_token(payload, exp = 15.minutes.to_i)
    payload[:type] = "access"
    payload[:exp]  = Time.now.to_i + exp
    payload[:jid]  = ActiveRecord::Base.connection.exec_query("SELECT nextval('jwt_id_sequence')").to_a.first["nextval"]
    JWT.encode(payload, @access_token_secret, "HS256")
  end

  def self.decode_access_token(token)
    decoded_token = JWT.decode(token, @access_token_secret, true, { algorithm: "HS256" }).first
    # TODO: Probably let the auth controller check the blacklist.
    BlacklistRedis.check(decoded_token)
    decoded_token
  end

  def self.create_refresh_token(payload, exp = 24.hours.to_i)
    payload[:type] = "refresh"
    payload[:exp]  = Time.now.to_i + exp
    payload[:jid]  = ActiveRecord::Base.connection.exec_query("SELECT nextval('jwt_id_sequence')").to_a.first["nextval"]
    JWT.encode(payload, @refresh_token_secret, "HS256",)
  end

  def self.decode_refresh_token(token)
    JWT.decode(token, @refresh_token_secret, true, { algorithm: "HS256" }).first
  end
end
