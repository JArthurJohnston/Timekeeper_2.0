class StoryCardsController < ApplicationController
  def index
    project_id = params[:project_id]
    if null_id? project_id
      @project = Project::NULL
    else
      @project = Project.find project_id
    end
    @projects = Project.all
    @story_cards = @project.story_cards
  end

  def show
    @story_card = find_story_card
    @activities = @story_card.activities
  end

  def new
    @story_card = StoryCard.new
    @submit_path = user_story_cards_path(@user.id)
  end

  def edit
    @story_card = find_story_card
    @submit_path = story_card_path
  end

  def create
    @story_card = StoryCard.create(story_card_params)
    redirect_to story_card_path
  end

  def update
    @story_card = find_story_card
    @story_card.update(story_card_params)
    redirect_to story_card_path
  end

  def delete
    @story_card = find_story_card
    @story_card.destroy!
    redirect_to action: :index
  end

  def select
    @projects = Project.all
  end

  def story_card_path
    user_project_story_card_path(@user.id, @story_card.project_id, @story_card.id)
  end

  def story_card_params
    params.require(:story_card).permit(:project_id, :description, :title, :number, :estimate)
  end

  def find_story_card
    StoryCard.find_by(project_id: params[:project_id], id: params[:id])
  end
end
