class StoryCardsController < ApplicationController

  def index
    @project = Project.find project_id_from_params
    @projects = Project.all
    @story_cards = @project.story_cards
    @select_symbol = :navigate_to_story_card
    @project_select_path = user_project_story_cards_path(@user.id, project_id_from_params)
  end

  def project_id_from_params
    unless params[:project_select].nil?
      project_id = params[:project_select][:selected_project]
    else
      project_id = params[:project_id]
    end
    project_id
  end

  def show
    @story_card = find_story_card
    @activities = @story_card.activities
  end

  def new
    @story_card = StoryCard.new
    @submit_path = user_project_story_cards_path(@user.id, @story_card.project.id)
  end

  def new_with_activity
    puts @user.name
  end

  def edit
    @story_card = find_story_card
    @submit_path = story_card_path
  end

  def create
    @story_card = StoryCard.create(story_card_params)
    redirect_to user_project_story_cards_path(@user.id, params[:project_id])
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
