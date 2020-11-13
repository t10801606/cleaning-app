class SuggestionsController < ApplicationController
  def index
    @suggestions = Suggestion.includes(:user)
    # indexアクションが実行されるたびに、掃除箇所の判定(statusカラムの更新)を行う
    @suggestions.each do |suggestion|
      this_day = Date.today
      num_days = (this_day - suggestion.last_cleaned_date).to_i
      if  suggestion.period_cleaning <= num_days
        suggestion.status = false
      else
        suggestion.status = true
      end
      suggestion.save
    end
  end

  def new
    @suggestion = Suggestion.new
  end

  def create
    @suggestion = Suggestion.new(suggestion_params)
    status_judge unless @suggestion.period_cleaning == nil && @suggestion.last_cleaned_date == nil
    if @suggestion.save
      redirect_to suggestions_path
    else
      render :new
    end
  end

  def update
    suggestion = Suggestion.find(params[:id])
    suggestion.last_cleaned_date = Date.today
    suggestion.save
    if suggestion.save
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
    if  @suggestion.period_cleaning <= num_days
      @suggestion.status = false
    else
      @suggestion.status = true
    end
  end
end
