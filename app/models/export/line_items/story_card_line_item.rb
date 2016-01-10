class StoryCardLineItem
  attr_reader :timesheet,
              :story_card

  def self.line_item_for timesheet, story_card
    return self.new(timesheet, story_card).to_csv
  end

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

  def total_activities the_activities
    total_time_for_activities = 0.0
    the_activities.each do
    |each_activity|
      total_time_for_activities += each_activity.total_time
    end
    total_time_for_activities
  end

  def weekday_totals_string
    activities_csv = ''
    work_week = DateRange.new(@timesheet.start_date, @timesheet.through_date).to_work_week
    work_week.each_day do
    |each_date|
      total = total_activities(activities_on(each_date))
      activities_csv.concat(if total > 0.0 then total.to_s else '' end).concat(',')
    end
    activities_csv
  end


  def line_item_string
    project = @story_card.project
    sow = project.statement_of_work
    "%{client},%{job_id},%{project} DEV - %{number},,,," % {
        client: sow.client,
        job_id: project.job_id,
        project: project.name,
        number: @story_card.number,
        billable: if project.billable? then 'Y' else 'N' end
    }
  end

  def to_csv
    line_item_string.concat(weekday_totals_string)
  end

end