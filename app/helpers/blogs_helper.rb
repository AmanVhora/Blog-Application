module BlogsHelper
  def user_authorized?(blog)
    blog.user == current_user
  end
end
