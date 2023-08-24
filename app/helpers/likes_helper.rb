module LikesHelper
  def blog_liked(blog)
    blog.likes.where(user_id: current_user.id).present?
  end

  def post_liked(post)
    post.likes.where(user_id: current_user.id).present?
  end
end
