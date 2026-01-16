class Api::V1::NotificationsController < Api::V1::ApplicationController
  include Authenticable

  # GET /notifications
  def index
    render json: { r: Notification.get() }
  end

  # GET /notifications/refresh
  def refresh
    render json: { r: Notification.get_unseen() }
  end
end
