class Admin::PaymentsController < Admin::AdminsController
  before_action :set_project
  before_action :set_payment, only: [:edit, :update, :destroy]

  def index
    @payments = @project.payments.all
    @project_name = @project.name
  end

  def new
    @payment = @project.payments.new
  end

  def edit
  end

  def create
    @payment = @project.payments.new(payment_params)

    respond_to do |format|
      if @payment.save
        format.html {redirect_to admin_projects_path, notice: "Payment succesfully created!"}
      else
        format.js { render :action => 'new', alert: "Please enter valid value!" }
      end
    end
  end

  def update
    if @payment.update(payment_params)
      redirect_to admin_project_payments_path(@project), notice: "Payment succesfully updated!"
    else
      render 'edit'
    end
  end

  def destroy
    @payment.destroy
    redirect_to admin_project_payments_path(@project)
  end

  private
  def set_project
     @project = Project.find(params[:project_id])
  end

  def set_payment
    @payment = @project.payments.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:amount)
  end
end
