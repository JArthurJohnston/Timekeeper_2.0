module TimesheetCSV

  def to_csv
    timesheet_csv = ''
    story_cards.each do
      |each_story_card|
      timesheet_csv.concat(StoryCardLineItem.new(self, each_story_card).to_csv).concat("\n")
    end
    return timesheet_csv
  end

end