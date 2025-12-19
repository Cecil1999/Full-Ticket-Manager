class Api::V1::NotificationsController < Api::V1::ApplicationController
  # GET /notifications
  def index
    render json: { e: "Unexpected error has occurred" } and return unless $current_user

    render json: { r: Notifiocations.orcish_notifications }
  end

  # GET /notifications/refresh
  def refresh
  end
end
