class ProjectsController < ApplicationController
  before_action :authenticate_manager, only: %i[delete new create edit update destroy]
  before_action :set_project_users, only: %i[new edit]
  before_action :set_client, only: %i[new create edit update]
  before_action :set_project, only: %i[edit update destroy]

  def index
    @projects = if current_user.user?
                  current_user.projects.includes(:client)
                else
                  Project.all.includes(:client)
                end
  end

  def show
    @project = if current_user.user?
                 current_user.projects.find(params[:id])
               else
                 Project.find(params[:id])
               end
    @comments = @project.comments.all.includes(:user)
    @attachments = @project.attachments
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
      set_project_users
      render 'new'
    end
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project), notice: 'Project succesfully updated!'
    else
      set_project_users
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

  def set_project_users
    @users = User.where(role: 'user')
  end

  def project_params
    params.require(:project).permit(:name, :client_id, user_ids: [], attachments_attributes: %i[id avatar _destroy])
  end
end
