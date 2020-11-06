class DesksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @desks = Desk.includes(:user).order('created_at DESC')
  end

  def new
    @desk = Desk.new
  end

  def create
    @desk = Desk.new(desk_params)
    if @desk.save
      redirect_to desks_path
    else
      render :new
    end
  end

  def show
    @desk = Desk.find(params[:id])
  end

  def edit
    @desk = Desk.find(params[:id])
  end

  def update
    if desk_data.update(desk_params)
      redirect_to desks_path
    else
      render :edit
    end
  end

  private

  def desk_params
    params.require(:desk).permit(:title, :concept, :image).merge(user_id: current_user.id)
  end
end
