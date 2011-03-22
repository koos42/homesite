module ApplicationHelper

  def user_is_author?
    return current_user && current_user.is_author
  end

end
