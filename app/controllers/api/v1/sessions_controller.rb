class Api::V1::SessionsController < Api::APIController
  skip_before_action :validate_request
  skip_before_action :validate_token
  skip_before_action :validate_current_user

  def create
    user = User.find_for_database_authentication(email: user_params[:email])
    return unsucessful_response(:unauthorized, 'User does not exist') if user.blank?

    if user.valid_password?(user_params[:password])
      return successful_response({ auth_token: JsonWebToken.encode(user_id: user.id) })
    else
      return unsucessful_response(:unauthorized, 'Password is incorrect')
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
