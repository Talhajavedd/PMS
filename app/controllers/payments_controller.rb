class PaymentsController < ApplicationController
  before_action :set_project
  before_action :set_payment, only: %i[edit update destroy]

  def index
    @payments = @project.payments.all
    authorize Payment
  end

  def new
    @payment = @project.payments.new
    authorize @payment
  end

  def edit; end

  def create
    @payment = @project.payments.new(payment_params)
    authorize @payment
    flash.now[:notice] = 'Payment succesfully created!' if @payment.save
  end

  def update
    if @payment.update(payment_params)
      redirect_to project_payments_path(@project), notice: 'Payment succesfully updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @payment.destroy
    redirect_to project_payments_path(@project)
  end

  def delete
    @project = Project.find(params[:project_id])
    @payment = @project.payments.find(params[:payment_id])
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_payment
    @payment = @project.payments.find(params[:id])
    authorize @payment
  end

  def payment_params
    params.require(:payment).permit(:amount)
  end
end
