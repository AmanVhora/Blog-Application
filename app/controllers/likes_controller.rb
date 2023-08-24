class LikesController < ApplicationController
  def create
    like_type = find_like_type
    @like = like_type.likes.build(user: current_user)

    if @like.save
      if @like.likable_type == "Post"
        redirect_to blog_post_path(like_type.blog_id, like_type.id)
      end
    else
      if @like.likable_type == "Blog"
        redirect_to blog_post_path(like_type.blog_id, like_type.id)
      end
    end
  end

  def destroy
    like_type = find_like_type
    @like = Like.find(params[:id])

    if @like.likable_type == "Post"
      if @like.user == current_user
        @like.destroy
        redirect_to blog_post_path(like_type.blog_id, like_type.id)
      end
    else
      if @like.user == current_user
        @like.destroy
        redirect_to blog_path(like_type.id)
      end
    end
  end

  private

  def find_like_type
    if params[:blog_id]
      Blog.find(params[:blog_id])
    elsif params[:post_id]
      Post.find(params[:post_id])
    end
  end
end
