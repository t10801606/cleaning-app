class UsersController < ApplicationController
  before_action :move_to_index, only: [:edit]
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def move_to_index
    unless user_signed_in?
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :line_token)
  end
end
