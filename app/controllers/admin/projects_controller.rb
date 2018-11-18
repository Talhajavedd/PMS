class Admin::ProjectsController < Admin::AdminsController
  before_action :set_client, only: %i[new create edit update]
  before_action :set_project, only: %i[show edit update destroy]
  before_action :set_project_users, only: %i[new edit create update]

  def index
    @projects = Project.search(params[:search], page: params[:page], per_page: 10, include: :client)
  end

  def show
    @commentable = @project
    @all_comments = @project.comments.page(params[:page]).includes(:user)
    @attachments = @project.attachments
    @all_time_logs = @project.time_logs.page(params[:page]).includes(:user)
  end

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
