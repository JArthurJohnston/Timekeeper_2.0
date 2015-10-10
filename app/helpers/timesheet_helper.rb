module TimesheetHelper

  def summary_div_for activity
    content_tag :div, class: 'summary-content' do
      if activity.nil?
        concat content_tag :p, '--'
      else
        current_story_card = activity.story_card
        concat content_tag :p, story_card_string_for(current_story_card)
        concat content_tag :p, estimate_string_for(current_story_card)
      end
    end
  end

  def story_card_string_for story_card
    "Card: %{project} : %{title}" %
        {project: story_card.project.name, title: story_card.title}
  end

  def estimate_string_for story_card
    "Actual/Estimate: %{actual}/%{estimate}" %
        {actual: story_card.billable_hours, estimate: story_card.estimate}
  end

end