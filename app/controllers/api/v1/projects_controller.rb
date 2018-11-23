class Api::V1::ProjectsController < Api::APIController
  before_action :set_project, only: %i[show]

  def index
    successful_response( Project.search_with(params, @current_user) )
  end

  def show
    unsucessful_response(404, 'Not Authorized') unless @project

    successful_response(@project)
  end

  private

  def set_project
    if @current_user.user?
      @project = @current_user.projects.find(params[:id])
    else
      @project = Project.find(params[:id])
    end
  end
end
