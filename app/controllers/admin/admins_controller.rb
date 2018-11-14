class Admin::AdminsController < ApplicationController
  before_action :authenticate_admin

  def index; end

  private

  def authenticate_admin
    return if current_user.admin?

    flash[:alert] = 'You are not authorized to access this page'
    redirect_to root_path
  end
end
