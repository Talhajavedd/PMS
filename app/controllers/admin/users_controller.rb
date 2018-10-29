class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path(@user), notice: "User succesfully created!"
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_without_password(user_params)
      redirect_to admin_user_path(@user)
    else
      render 'edit'
    end
  end

  def deactivate
  	@user = User.find(params[:user_id])
  	if @user.status
     user.enable_user
   else
     user.disable_user
   end
 end

 def destroy
   @user = User.find(params[:id])
   @user.destroy
   redirect_to admin_users_path
 end

  private
  def user_params
    params.require(:user).permit(:username, :role, :email, :password, :password_confirmation
      )
  end
end
