class Admin::ProjectsController < Admin::AdminsController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = Project.all
  end

  def show; end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to admin_projects_path(@project), notice: 'Project succesfully created!'
    else
      render 'new'
    end
  end

  def update
    if @project.update(project_params)
      redirect_to admin_project_path(@project), notice: 'Project succesfully updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to admin_projects_path
  end

  def delete
    @project = Project.find(params[:project_id])
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :client_id)
  end
end
