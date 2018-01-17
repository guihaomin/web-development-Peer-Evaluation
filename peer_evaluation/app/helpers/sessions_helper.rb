module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def write_eva(name, str, evaluation)
    if str.index(name+":")==nil
      str+=name+": "+evaluation+"\n"
      return str
    else
      return nil
    end
  end

  def can_write(name, str)
    if (str==nil)
      return true
    end
    return str.index(name+":")==nil
  end
  def find_all_users(groupID)
    userSet=[]
    UserAndGroup.where(groupID:groupID).to_a.each do |record|
      userSet.push(record.userID)
    end
    return userSet
  end
end
