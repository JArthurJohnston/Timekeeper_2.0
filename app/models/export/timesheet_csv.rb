module TimesheetCSV

  def activities_for_card_on story_card_id, date_time
    date = DateWrapper.new date_time
    activities.where('story_card_id = ? AND start_time >= ? AND end_time <= ? AND timesheet_id = ?',
                     story_card_id, date.at_start, date.at_end, self.id)
  end

  def to_csv
    current_date = start_date.to_date
    work_week = DateRange.new(self.start_date, self.through_date).to_work_week
    timesheet_csv = ''
    story_cards.each do
      |each_story_card|
      each_card_csv = 'client,jobId,projectName - DEV card_number,Y,Y,,,'
      work_week.each_day do
        |each_date|
        total_time_for_card  = 0.0
        activities_for_card_on(each_story_card.id, each_date).each do
          |each_activity|
          total_time_for_card += each_activity.total_time
        end
        each_card_csv.concat(total_time_for_card).concat(',')
        timesheet_csv.concat(each_card_csv).concat('\n')
      end
    end
    return timesheet_csv
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