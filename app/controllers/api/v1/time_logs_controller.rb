class Api::V1::TimeLogsController < Api::APIController
  before_action :set_project

  def index
    successful_response(@project.time_logs)
  end

  private

  def set_project
    if @current_user.user?
      @project = @current_user.projects.find(params[:project_id])
    else
      @project = Project.find(params[:project_id])
    end
  end
end
