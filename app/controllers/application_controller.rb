class ApplicationController < ActionController::Base
  include ExceptionHandler

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :application_layout

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_projects_path
    else
      root_path
    end
  end

  protected

  def authenticate_manager
    return if current_user.manager?

    flash[:alert] = 'You should be a manager to access this page'
    redirect_to root_path
  end

  def configure_permitted_parameters
    added_attrs = %i[username remember_me email password password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  private

  def application_layout
    if current_user
      'logged_in_layout'
    else
      'application'
    end
  end
end
