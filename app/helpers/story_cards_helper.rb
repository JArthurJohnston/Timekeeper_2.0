module StoryCardsHelper

  def select_story_card_for_activity story_card
    link_to create_activity_for_timesheet_path(@user.id, params[:timesheet_id], story_card.id), method: :post do
      concat(content_tag :div, story_card.display_string)
    end
  end

  def navigate_to_story_card story_card
    link_to user_project_story_card_path @user.id, story_card.project_id, story_card.id do
      concat(content_tag :div, story_card.display_string)
    end
  end

end
