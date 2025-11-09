module Authenticable extend ActiveSupport::Concern
  included do
    before_action :authenticate_user
  end

  private
  def authenticate_user
    @token = request.headers['Authorization'].split(" ").last
    decoded_token = JsonWebToken.decode(@token)
    @current_user = User.find_by(id: decoded_token[:id])
    rescue JWT::VerificationError # No token or invalid token
      render json: { error: "Unauthorized" }, status: :unauthorized
  end
end
