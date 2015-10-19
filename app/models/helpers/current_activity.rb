module CurrentActivity

  def current_activity
    found_activity = Activity.find_by(id: self.current_activity_id)
    if found_activity.nil?
      return Activity::NULL
    end
    return found_activity
  end

  def current_project
      return current_activity.project
  end

  def current_story_card
      return current_activity.story_card
  end

end