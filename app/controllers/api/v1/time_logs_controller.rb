class Api::V1::TimeLogsController < Api::APIController
  before_action :set_project

  def index
    successful_response(TimeLogSerializer.new(@project.time_logs.includes(:user).page(params[:page])).serializable_hash)
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
