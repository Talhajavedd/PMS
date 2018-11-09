class ProjectsController < ApplicationController
  before_action :set_client, only: %i[new create edit update]
  before_action :set_project, only: %i[show edit update destroy]
  before_action only: %i[delete new create edit update destroy] do
    authenticate_manager
  end

  def index
    @projects = Project.all.includes(:client)
  end

  def show
    @comments = @project.comments.all
  end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to projects_path(@project), notice: 'Project succesfully created!'
    else
      render 'new'
    end
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project), notice: 'Project succesfully updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  def delete
    @project = Project.find(params[:project_id])
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def set_client
    @clients = Client.all
  end

  def project_params
    params.require(:project).permit(:name, :client_id)
  end
end
