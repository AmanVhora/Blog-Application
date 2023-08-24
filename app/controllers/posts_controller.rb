class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy authorize_user ]
  before_action :set_blog
  before_action :authorize_user, except: %i[ index show ]

  def index
    @posts = @blog.posts.all
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = @blog.posts.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to blog_post_path(@blog, @post), notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to blog_post_path(@blog, @post), notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to blog_posts_path(@blog), notice: "Post was successfully destroyed."
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :post_image, :post_category_id)
  end

  def set_blog
    @blog = Blog.find(params[:blog_id])
  end

  def authorize_user
    redirect_to blog_posts_path(@blog, @post), flash: { alert: 'You can only create posts of your own blog' } unless @blog.user == current_user
  end
end
