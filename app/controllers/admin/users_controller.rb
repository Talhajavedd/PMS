class Admin::UsersController < Admin::AdminsController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :set_user_activiation]

  def index
    @users = User.non_admin_users
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
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
    if @user.update_without_password(user_params)
      redirect_to admin_user_path(@user)
    else
      render 'edit'
    end

  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  def set_user_activiation
    @user.toggle_enable
    redirect_to admin_users_path(@user)
  end

  def set_user
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:username, :role, :email, :password, :password_confirmation
      )
  end
end
