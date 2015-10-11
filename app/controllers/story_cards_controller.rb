class StoryCardsController < ApplicationController
  def index
    @story_cards = StoryCard.all
  end
end
