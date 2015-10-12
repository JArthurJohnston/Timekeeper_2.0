module TimesheetDisplay

  def display_string
    return '%{start} to %{end}' % {
        start: display_string_for(self.start_date),
        end: display_string_for(self.through_date)
    }
  end

  private
    def display_string_for aDate
      aDate.strftime('%a %b %-d')
    end

end