class CommentsController < ApplicationController
  before_action :find_resources

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to blog_post_path(@blog, @post), notice: 'Comment created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.user == current_user
      @comment.destroy
      redirect_to blog_post_path(@blog, @post), notice: 'Comment deleted successfully.'
    end
  end

  private

  def find_resources
    @blog = Blog.find(params[:blog_id])
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end  
