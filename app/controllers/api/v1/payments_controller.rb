class Api::V1::PaymentsController < Api::APIController
  before_action :set_project

  def index
    successful_response(PaymentSerializer.new(@project.payments.page(params[:page])).serializable_hash)
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end
end
