class SuggestionsController < ApplicationController
  before_action :authenticate_user!, except: :clean

  def clean
    @suggestions = Suggestion.includes(:user)
    # cleanアクションが実行されるたびに、掃除箇所の判定(statusカラムの更新)を行う
    @suggestions.each do |suggestion|
      this_day = Date.today
      num_days = (this_day - suggestion.last_cleaned_date).to_i
      suggestion.status = !(suggestion.period_cleaning <= num_days)
      suggestion.save
    end
  end

  def index
    @suggestions = Suggestion.includes(:user)
  end

  def new
    @suggestion = Suggestion.new
  end

  def create
    @suggestion = Suggestion.new(suggestion_params)
    status_judge unless @suggestion.period_cleaning.nil? || @suggestion.last_cleaned_date.nil?
    if @suggestion.save
      redirect_to clean_suggestions_path
    else
      render :new
    end
  end

  def finish
    suggestion = Suggestion.find(params[:id])
    suggestion.last_cleaned_date = Date.today
    suggestion.save
    if suggestion.save
      redirect_to clean_suggestions_path
    else
      render :clean
    end
  end

  def edit
    @suggestion = Suggestion.find(params[:id])
  end

  def update
    @suggestion = Suggestion.find(params[:id])
    status_judge unless @suggestion.period_cleaning.nil? || @suggestion.last_cleaned_date.nil?
    if @suggestion.update(suggestion_params)
      redirect_to suggestions_path
    else
      render :edit
    end
  end

  def destroy
    suggestion = Suggestion.find(params[:id])
    if current_user.id == suggestion.user_id
      suggestion.destroy
      redirect_to suggestions_path
    else
      render :index
    end
  end

  private

  def suggestion_params
    params.require(:suggestion).permit(:place, :period_cleaning, :last_cleaned_date, :status).merge(user_id: current_user.id)
  end

  def status_judge
    this_day = Date.today
    num_days = (this_day - @suggestion.last_cleaned_date).to_i
    @suggestion.status = !(@suggestion.period_cleaning <= num_days)
  end

end
