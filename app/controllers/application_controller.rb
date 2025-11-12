class ApplicationController < ActionController::API
  rescue_from JWT::VerificationError, with: :handle_unauthorized_token_failure
  rescue_from JWT::ExpiredSignature, with: :handle_expired_signature
  rescue_from Errno::ECONNRESET, with: :handle_connection_failure
  rescue_from Authenticable::BlackListedJWTTokenSpotted, with: :handle_blacklisted_jwt

  private
  def handle_unauthorized_token_failure
    render json: { e: "Forbidden" }, status: 403
  end

  def handle_expired_signature
    render json: { sign_back_in: 1, r: "Redirecting back to sign-in..." }, status: 403
  end

  def handle_cache_connection_failure
    render json: { e: "Connection with cache has been disconnected, please contact administrator" }, status: 500
  end

  def handle_blacklisted_jwt
    render json: { r: "Hacking Attempt has been seen, and logged. Please stop." }, status: 403
  end
end
