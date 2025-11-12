module Authenticable extend ActiveSupport::Concern
  class BlackListedJWTTokenSpotted < StandardError; end

  included do
    before_action :authenticate_user
  end

  private
  def authenticate_user
    token = request.headers["Authorization"].split(" ").last
    decoded_token = JsonWebToken.decode(token)
    current_user = User.find_by(id: decoded_token[:id])
  end
end
