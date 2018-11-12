class TimeLogsController < ApplicationController
  before_action :set_project
  before_action :set_time_log, only: %i[edit update destroy]

  def index
    if current_user.user?
      @time_logs = @project.time_logs.where(user_id: current_user.id).all
    else
      @time_logs = @project.time_logs.all
    end
    @project_name = @project.name
  end

  def new
    @time_log = @project.time_logs.new
  end

  def edit; end

  def create
    @time_log = @project.time_logs.new(time_log_params)
    @time_log.user_id = current_user.id
    flash.now[:notice] = 'Time added succesfully created!' if @time_log.save
  end

  def update
    if @time_log.update(time_log_params)
      redirect_to project_time_logs_path(@project), notice: 'Time succesfully updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @time_log.destroy
    redirect_to project_time_logs_path(@project)
  end

  def delete
    @project = current_user.projects.find(params[:project_id])
    @time_log = @project.time_logs.find(params[:time_log_id])
  end

  private

  def set_project
    if current_user.user?
      @project = current_user.projects.find(params[:project_id])
    else
      @project = Project.find(params[:project_id])
    end
  end

  def set_time_log
    if current_user.user?
      @time_log = current_user.time_logs.where(project_id: @project.id).find(params[:id])
    else
      @time_log = TimeLog.find(params[:id])
    end 
  end

  def time_log_params
    params.require(:time_log).permit(:date, :hours)
  end
end
