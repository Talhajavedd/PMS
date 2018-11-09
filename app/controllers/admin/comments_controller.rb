class Admin::CommentsController < Admin::AdminsController
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
      redirect_to [:admin, @commentable], notice: 'Comment succesfully updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to [:admin, @commentable]
  end

  private

  def find_commentable
    params.each do |name, value|
      return Regexp.last_match(1).classify.constantize.find(value) if name =~ /(.+)_id$/
    end
  end

  def set_commentable
    @commentable = find_commentable
  end

  def set_comment
    @commentable = find_commentable
    @comment = @commentable.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
