class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: %i[edit update destroy]

  def new
    @comments = @commentable.comments.last(5)
    @comment = @commentable.comments.new
  end

  def edit; end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    @comments = @commentable.comments.last(5)
  end

  def update
    if @comment.update(comment_params)
      redirect_to @commentable, notice: 'Comment succesfully updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to @commentable
  end

  private

  def set_commentable
    resource, id = request.path.split('/')[1, 2]
    if resource == 'projects'
      set_project
    else
      @commentable = resource.singularize.classify.constantize.find(id)
    end
  end

  def set_project
    if current_user.user?
      @commentable = current_user.projects.find(params[:project_id])
    else
      @commentable = Project.find(params[:project_id])
    end
  end

  def set_comment
    @comment = @commentable.comments.where(user_id: current_user.id).find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
