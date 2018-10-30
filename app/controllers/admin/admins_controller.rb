class Admin::AdminsController < ApplicationController
  before_action :authenticate_admin

  def authenticate_admin
    unless current_user.admin?
      flash[:error] = "You should be an admin to access this page"
      redirect_to root_path
    end
  end
end
