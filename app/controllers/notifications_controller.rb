class NotificationsController < ApplicationController
  before_action :require_login

  def index
    @notifications = User.current.notifications.order(created_at: :desc)
  end

  def show
    @notification = User.current.notifications.find(params[:id])
    @notification.update(read: true)
  end

  def update
    @notification = User.current.notifications.find(params[:id])
    if @notification.update(notification_params)
      redirect_to notifications_path, notice: '通知已更新'
    else
      render :show
    end
  end

  def mark_as_read
    @notification = User.current.notifications.find(params[:id])
    @notification.update(read: true)
    head :ok
  end

  def unread_count
    count = User.current.notifications.where(read: false).count
    render json: { unread_count: count }
  end

  private

  def notification_params
    params.require(:notification).permit(:read)
  end
end 