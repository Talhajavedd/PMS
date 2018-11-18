class TimeLogsController < ApplicationController
  before_action :set_project
  before_action :set_time_log, only: %i[edit update destroy]

  def index
    @time_logs = @project.time_logs.page(params[:page]).includes(:user)
    authorize TimeLog
    @project_name = @project.name
  end

  def new
    @time_log = @project.time_logs.new
    authorize @time_log
  end

  def edit; end

  def create
    @time_log = @project.time_logs.new(time_log_params)
    @time_log.user_id = current_user.id
    authorize @time_log
    flash.now[:notice] = 'Time added succesfully created!' if @time_log.save
    @all_time_logs = @project.time_logs.page(params[:page]).includes(:user)
  end

  def update
    if @time_log.update(time_log_params)
      redirect_to @project, notice: 'Time succesfully updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @time_log.destroy
    redirect_to @project
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
    authorize @project, :show?
  end

  def set_time_log
    @time_log = @project.time_logs.find(params[:id])
    authorize @time_log
  end

  def time_log_params
    params.require(:time_log).permit(:date, :hours)
  end
end
