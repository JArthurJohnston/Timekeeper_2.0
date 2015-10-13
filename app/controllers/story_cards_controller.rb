class StoryCardsController < ApplicationController
  def index
    @story_cards = StoryCard.all
  end

  def show
    @story_card = StoryCard.find_by(project_id: params[:project_id], id: params[:id])
    @activities = @story_card.activities
  end


  def new
    @story_card = StoryCard.new
    @submit_path = user_project_story_card_path(@user.id, params[:project_id])

  end
end
