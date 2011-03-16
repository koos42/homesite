class ApplicationController < ActionController::Base
  protect_from_forgery

  # PRIVATES!!!
  private
  
  def require_author_status
    unless current_user && current_user.is_author
      flash[:alert] = "You've gotta be an author to pull that."
      return self.latest
    end
  end
end
