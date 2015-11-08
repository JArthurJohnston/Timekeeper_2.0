module TimesheetCSV

  def activities_for_card_on story_card_id, date_time
    activities.where('story_card_id = ? AND start_time >= ? AND end_time <= ? AND timesheet_id = ?',
                     story_card_id, date_time.beginning_of_day, date_time.end_of_day, self.id)
  end

  def line_item_string_for a_story_card
    project = a_story_card.project
    sow = project.statement_of_work
    "%{client},%{job_id},%{project} DEV - %{number},Y,%{billable},,," % {
        client: sow.client,
        job_id: project.job_id,
        project: project.name,
        number: a_story_card.number,
        billable: billable_string_for(project)
    }
  end

  def billable_string_for a_project
    if a_project.billable? then 'Y' else 'N' end
  end

  def to_csv
    timesheet_csv = ''
    story_cards.each do
      |each_story_card|
      each_card_csv = weekday_totals_string_for(each_story_card)
      timesheet_csv.concat(each_card_csv).concat("\n")
    end
    return timesheet_csv
  end

  def weekday_totals_string_for(each_story_card)
    each_card_csv = line_item_string_for each_story_card
    work_week = DateRange.new(self.start_date, self.through_date).to_work_week
    work_week.each_day do
      |each_date|
      each_card_csv.concat(
          total_string_for_activities(
              activities_for_card_on(each_story_card.id, each_date)))
    end
    each_card_csv
  end

  def total_string_for_activities activities
    total_time_for_card = 0.0
    activities.each do
      |each_activity|
      total_time_for_card += each_activity.total_time
    end
    total_String = if total_time_for_card > 0.0 then total_time_for_card.to_s else '' end
    return total_String.concat(',')
  end

  class DateWrapper
    attr_reader :date_time

    def initialize date_time
      @date_time = date_time
    end

    def at_start
      return DateTime.new(@date_time.year, @date_time.month, @date_time.day, 0, 0, 0)
    end

    def at_end
      return DateTime.new(@date_time.year, @date_time.month, @date_time.day, 24, 0, 0)
    end
  end

end