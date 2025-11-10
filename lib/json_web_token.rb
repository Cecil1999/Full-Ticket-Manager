module JsonWebToken
  # Need to figure out a good way to 'Store' secret_key for the signature. For now.... just use the test Key.
  @hmac_secret = "kWnVtZA2LezioE6c9TvP0ZRyT7mydZLKG49MafhX9GE="
  # Self Encoding
  def self.encode(payload, exp = 1.hour.to_i)
    payload[:exp] = Time.now.to_i + exp
    JWT.encode(payload, @hmac_secret, "HS256")
  end

  # Self Decode
  def self.decode(token)
    hmac_secret = "kWnVtZA2LezioE6c9TvP0ZRyT7mydZLKG49MafhX9GE="
    decoded_token = JWT.decode(token, @hmac_secret, true, { algorithm: "HS256" }).first
    rescue JWT::VerificationError => e
      nil
  end
end
