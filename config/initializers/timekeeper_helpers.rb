class TimekeeperHelpers

  class << self

    def update_activity_timezones_to an_offset_string
      Activity.all.each do
        |each_activity |
        new_start = each_activity.start_time.to_datetime.new_offset(an_offset_string)
        new_end = each_activity.end_time.to_datetime.new_offset(an_offset_string)
        each_activity.update_attribute(:start_time, new_start)
        each_activity.update_attribute(:end_time, new_end)
      end
    end

  end

end