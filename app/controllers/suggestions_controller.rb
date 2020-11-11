class SuggestionsController < ApplicationController
  def index
  end

  def new
    @suggestion = Suggestion.new
  end
end
