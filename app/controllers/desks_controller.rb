class DesksController < ApplicationController
  def index
    @desks = Desk.includes(:user).order("created_at DESC")
  end
  
end
