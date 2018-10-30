class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_manager, only: [:new, :edit, :update, :destroy]
  before_action :authenticate_admin, only: [:index]

  def index
    @clients = Client.all
  end

  def show
  end

  def new
    @client = Client.new
  end

  def edit
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to clients_path(@client), notice: "Client succesfully created!"
    else
      render 'new'
    end
  end

  def update
    if @client.update(client_params)
      redirect_to client_path(@client)
    else
      render 'edit'
    end
  end

  def destroy
    @client.destroy
    redirect_to clients_path
  end

  private
  def authenticate_manager
    unless current_user.role == "manager"
      flash[:error] = "You should be a manager to access this page"
      redirect_to clients_path
    end
  end

  def authenticate_admin
    if current_user.admin?
      redirect_to admin_clients_path
    end
  end

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:name, :company)
  end
end
