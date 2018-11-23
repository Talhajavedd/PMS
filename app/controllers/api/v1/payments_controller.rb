class Api::V1::PaymentsController < Api::APIController
  before_action :set_project

  def index
    successful_response(@project.payments.page(params[:page]))
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end
end
