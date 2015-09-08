class ApplicationController < ActionController::Base
  protect_from_forgery

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, :with => :render_error
    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
    rescue_from ActionController::RoutingError, :with => :render_not_found
    rescue_from ActionController::UnknownController, :with => :render_not_found
    rescue_from ActionController::UnknownAction, :with => :render_not_found
  end

private

  def require_author_status
    unless current_user && current_user.is_author
      flash[:alert] = "You've gotta be an author to pull that."
      return self.latest
    end
  end

  def render_not_found(exception)
    render :template => "/errors/four_oh_four.html.erb", :status => 404
  end

  def render_error(exception)
    #TODO: insert logging stuff....
    render :template => "/errors/five_hundred.html.erb", :status => 500
  end
end
