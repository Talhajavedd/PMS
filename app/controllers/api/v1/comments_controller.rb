class Api::V1::CommentsController < Api::APIController
  before_action :set_commentable

  def index
    successful_response(CommentSerializer.new(@commentable.comments.includes(:user).page(params[:page])).serializable_hash)
  end

  private

  def set_commentable
    if @current_user.user?
      @commentable = @current_user.projects.find(params[:project_id])
    else
      @commentable = Project.find(params[:project_id])
    end
  end
end
