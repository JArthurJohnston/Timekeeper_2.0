module TimesheetCSV

  def to_csv
    timesheet_csv = ''
    story_cards.each do
      |each_story_card|
      timesheet_csv.concat(StoryCardLineItem.new(self, each_story_card).to_csv).concat("\n")
    end
    return timesheet_csv
  end

  def story_card_line_items
    line_items = []
    story_cards.sort {|a, b| a.project.name < b.project.name}.each do
      |each_card|
      line_items.push(StoryCardLineItem.new(self, each_card))
    end
    line_items
  end

end