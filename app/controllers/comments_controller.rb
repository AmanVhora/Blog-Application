class CommentsController < ApplicationController
  def new
    @comment_type = find_comment_type.comments.new
  end

  def create
    comment_type = find_comment_type
    @comment = comment_type.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      if @comment.commentable_type == "Post"
        redirect_to blog_post_path(comment_type.blog_id, comment_type.id), notice: 'Comment created successfully.'
      else
        redirect_to blog_path(comment_type.id), notice: 'Comment created successfully.'
      end
    else
      if @comment.commentable_type == "Post"
        redirect_to blog_post_path(comment_type.blog_id, comment_type.id), alert: 'Comment not saved.'
      else
        redirect_to blog_path(comment_type.id), alert: 'Comment not saved.'
      end
    end
  end

  def destroy
    comment_type = find_comment_type
    @comment = Comment.find(params[:id])
    
    if @comment.commentable_type == "Post"
      if @comment.user == current_user
        @comment.destroy
        redirect_to blog_post_path(comment_type.blog_id, comment_type.id), notice: 'Comment deleted successfully.'
      else
        redirect_to blog_post_path(comment_type.blog_id, comment_type.id), alert: 'You are not authorized to delete this comment.'
      end
    else
      if @comment.user == current_user
        @comment.destroy
        redirect_to blog_path(comment_type.id), notice: 'Comment deleted successfully.'
      else
        redirect_to blog_path(comment_type.id), alert: 'You are not authorized to delete this comment.'
      end
    end
  end

  private

  def find_comment_type
    if params[:blog_id]
      Blog.find(params[:blog_id])
    elsif params[:post_id]
      Post.find(params[:post_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end  
