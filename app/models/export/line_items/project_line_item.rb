class ProjectLineItem
  attr_reader :timesheet,
              :project

  def self.line_item_for timesheet, project
    return self.new(timesheet, project).to_csv
  end

  def initialize timesheet, project
    @timesheet = timesheet
    @project = project
  end

  def story_cards
    @timesheet.story_cards.select {|e| e.project_id == @project.id}
  end

  def to_csv
    cards = story_cards.sort_by { |c| c.number}
    csv_to_return = ''
    cards.each do
      |each_card|
      csv_to_return += StoryCardLineItem.line_item_for(@timesheet, each_card)
      csv_to_return += "\n"
    end
    csv_to_return
  end
end