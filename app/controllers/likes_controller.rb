class LikesController < ApplicationController
  before_action :find_resources

  def create
    @like = @post.likes.new(user: current_user)

    if @like.save
      redirect_to blog_post_path(@blog, @post)
    end
  end

  def destroy
    @like = Like.find(params[:id])

    if @like.user == current_user
      @like.destroy
      redirect_to blog_post_path(@blog, @post)
    end
  end

  private

  def find_resources
    @blog = Blog.find(params[:blog_id])
    @post = Post.find(params[:post_id])
  end
end
