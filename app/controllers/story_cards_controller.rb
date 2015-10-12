class StoryCardsController < ApplicationController
  def index
    @story_cards = StoryCard.all
  end

  def show
    @story_card = StoryCard.find_by(project_id: params[:project_id], id: params[:id])
    @activities = @story_card.activities
  end
end
