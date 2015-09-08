module ApplicationHelper
  def user_is_author?
    current_user && current_user.is_author
  end

  def any_goodies?
    @haz_goodies ||= Goody.any?
  end
end
