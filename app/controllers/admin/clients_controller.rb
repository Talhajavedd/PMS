class Admin::ClientsController < Admin::AdminsController
  before_action :set_client, only: %i[show edit update destroy]

  def index
    @clients = Client.search params[:search]
  end

  def show; end

  def new
    @client = Client.new
  end

  def edit; end

  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to admin_clients_path(@client), notice: 'Client succesfully created!'
    else
      render 'new'
    end
  end

  def update
    if @client.update(client_params)
      redirect_to admin_client_path(@client)
    else
      render 'edit'
    end
  end

  def destroy
    @client.destroy
    redirect_to admin_clients_path
  end

  def delete
    @client = Client.find(params[:client_id])
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:name, :company)
  end
end
