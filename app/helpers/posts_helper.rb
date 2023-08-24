module PostsHelper
  def user_authorized?(post)
    post.user_id == current_user.id
  end

  def blog_user_authorized?(blog)
    blog.user == current_user
  end
end
