class Admin::TimeLogsController < Admin::AdminsController
  before_action :set_project
  before_action :set_time_log, only: %i[edit update destroy]

  def index
    @time_logs = @project.time_logs.all
    @project_name = @project.name
  end

  def new
    @time_log = @project.time_logs.new
  end

  def edit; end

  def create
    @time_log = @project.time_logs.new(time_log_params)
    flash.now[:notice] = 'Time added succesfully created!' if @time_log.save
  end

  def update
    if @time_log.update(time_log_params)
      redirect_to admin_project_time_logs_path(@project), notice: 'Time succesfully updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @time_log.destroy
    redirect_to admin_project_time_logs_path(@project)
  end

  def delete
    @project = Project.find(params[:project_id])
    @time_log = @project.time_logs.find(params[:time_log_id])
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_time_log
    @time_log = TimeLog.find(params[:id])
  end

  def time_log_params
    params.require(:time_log).permit(:date, :hours)
  end
end
