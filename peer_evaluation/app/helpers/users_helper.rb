module UsersHelper
  def render_for(user)
    render_id= Digest::MD5::hexdigest(user.email.downcase)
  end
end
