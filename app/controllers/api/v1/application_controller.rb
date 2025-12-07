class Api::V1::ApplicationController < ActionController::API
  rescue_from JWT::VerificationError, with: :forbidden
  rescue_from JWT::ExpiredSignature, with: :handle_expired_signature
  rescue_from Errno::ECONNRESET, with: :handle_connection_failure
  rescue_from Authenticable::BlackListedJWTTokenSpotted, with: :handle_blacklisted_jwt
  rescue_from Authorizable::NotAuthorized, with: :forbidden
  rescue_from Authorizable::FunctionAuthNotEnabled, with: :call_attention_to_admins
  rescue_from Authorizable::FunctionAuthHasNoRoles, with: :call_attention_to_admins
  wrap_parameters false

  private
  def forbidden
    render json: { e: "Forbidden" }, status: 403
  end

  def call_attention_to_admins
    render json: { e: "Forbidden. Contact Administrators." }, status: 403
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
