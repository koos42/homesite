class ErrorsController < ApplicationController

  def four_oh_four
    render 'four_oh_four', :status => 404    
  end

  def five_hundred
    render 'five_hundred', :status => 500
  end

end
