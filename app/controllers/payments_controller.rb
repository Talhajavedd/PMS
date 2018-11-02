class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  before_action do
    authenticate_manager(root_path)
  end

  def index
    @payments = Payment.all
  end

  def show
  end

  def new
    @payment = Payment.new
  end

  def edit
  end

  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      redirect_to payments_path(@payment), notice: "Payment succesfully created!"
    else
      render 'new'
    end
  end

  def update
    if @payment.update(payment_params)
      redirect_to payment_path(@payment), notice: "Payment succesfully updated!"
    else
      render 'edit'
    end
  end

  def destroy
    @payment.destroy
    redirect_to payments_path
  end

  private
  def set_payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :project_id)
  end
end
