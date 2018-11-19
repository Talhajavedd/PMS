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
    @all_comments = @commentable.comments.page(params[:comment_page]).includes(:user)
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
    @commentable = resource.singularize.classify.constantize.find(id)
    authorize @commentable, :show?
  end

  def set_comment
    @comment = @commentable.comments.find(params[:id])
    authorize @comment
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
