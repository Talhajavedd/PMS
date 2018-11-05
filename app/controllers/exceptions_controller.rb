class ExceptionsController < ApplicationController
  def catch_404
    raise ActionController::RoutingError, params[:path]
  end
end
