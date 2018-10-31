module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::RoutingError, with: :route_deny_access
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  end

  def route_deny_access
    logger.error 'Route does not exist'
    return redirect_to :root, alert: 'Route does not exist'
  end

  def record_not_found
    logger.error 'Resource does not exist'
    return redirect_to :root, alert: 'Resource does not exist'
  end
end
