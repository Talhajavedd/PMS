class Api::APIController < ActionController::API
  include AuthenticationConcern
  
  protected

  def successful_response(content)
    render json: { data: content, success: true }, status: 200
  end

  def unsucessful_response(status, message)
    render json: {error: message, success: false}, status: status
  end
end




