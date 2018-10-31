class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_root_index_path
    else
      root_path
    end
  end

  protected
  def authenticate_manager
    unless current_user.manager?
      flash[:error] = "You should be a manager to access this page"
      redirect_to clients_path
    end
  end

  def configure_permitted_parameters
    added_attrs = [:username, :remember_me, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
