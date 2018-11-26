class Api::V1::ProjectsController < Api::APIController
  before_action :set_project, only: %i[show]
  before_action :set_serializer_options, only: %i[show]

  def index
    successful_response(Project.search_with(params, @current_user))
  end

  def show
    unsucessful_response(404, 'Not Authorized') unless @project

    successful_response(ProjectSerializer.new(@project, @options).serializable_hash)
  end

  private

  def set_serializer_options
    @options = { params: {} }
    @options[:params][:comment_page] = params[:comment_page]
    @options[:params][:time_log_page] = params[:time_log_page]
    @options[:include] = [:client, :users, :payments]
  end

  def set_project
    if @current_user.user?
      @project = @current_user.projects.find(params[:id])
    else
      @project = Project.find(params[:id])
    end
  end
end
