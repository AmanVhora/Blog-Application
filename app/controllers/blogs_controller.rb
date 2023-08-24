class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy authorize_user ]
  before_action :authorize_user, only: %i[ edit update destroy ]

  def index
    @blogs = Blog.all
  end

  def show; end

  def new
    @blog = current_user.blogs.new
  end

  def edit; end

  def create
    @blog = current_user.blogs.new(blog_params)

    if @blog.save
      redirect_to blog_path(@blog), notice: "Blog was successfully created."
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to blog_path(@blog), notice: "Blog was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: "Blog was successfully destroyed."
  end

  private
  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :description, :cover_image)
  end

  def authorize_user
    redirect_to blogs_path, flash: { alert: 'You have not access to modify this blog' } unless @blog.user == current_user
  end
end
