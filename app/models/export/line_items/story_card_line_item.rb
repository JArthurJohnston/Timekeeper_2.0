class StoryCardLineItem
  attr_reader :timesheet,
              :story_card

  def initialize timesheet, story_card
    @timesheet = timesheet
    @story_card = story_card
  end

  def activities
    return Activity.where timesheet_id: @timesheet.id, story_card_id: @story_card.id
  end

  def activities_on a_date
    dates_activities = []
    activities.each do
      |each_activity|
      if each_activity.start_time.to_datetime.cwday == a_date.to_datetime.cwday
        dates_activities.push each_activity
      end
    end
    dates_activities
  end

end