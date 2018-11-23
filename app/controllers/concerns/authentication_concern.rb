module AuthenticationConcern
  extend ActiveSupport::Concern

  included do
    before_action :validate_request
    before_action :validate_token
    before_action :validate_current_user
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  end

  def encoded_jwt
    request.headers['Authorization']
  end

  def decoded_jwt
    JsonWebToken.decode(encoded_jwt)
  end

  def current_user
    @current_user ||= User.find(decoded_jwt[:user_id])
  end

  private

  def record_not_found(error)
    render json: {error: error.message}, status: :not_found
  end

  def validate_request
    return unsucessful_response(:token, 'Missing token') unless encoded_jwt.present?
  end

  def validate_token
    return unsucessful_response(:token, 'Invalid Token In Request header') if decoded_jwt.blank?
  end

  def validate_current_user
    return unsucessful_response(:user, 'User not found') if current_user.blank?
  end
end
