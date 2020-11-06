class DesksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, only: [:edit]
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
    @desk = Desk.find(params[:id])
    if @desk.update(desk_params)
      redirect_to desks_path
    else
      render :edit
    end
  end

  private

  def desk_params
    params.require(:desk).permit(:title, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    @desk = Desk.find(params[:id])
    redirect_to action: :index unless current_user.id == @desk.user_id
  end
end
