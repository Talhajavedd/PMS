module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::RoutingError, with: :route_deny_access
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  def route_deny_access
    logger.error 'Route does not exist'
    redirect_to :root, alert: 'Route does not exist'
  end

  def record_not_found
    logger.error 'Resource does not exist'
    redirect_to :root, alert: 'Resource does not exist'
  end

  def user_not_authorized(_exception)
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to root_path
  end
end
