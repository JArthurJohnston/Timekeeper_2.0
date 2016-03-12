module UserAccessAdmin

  def can_access_Timesheet? timesheet
    timesheet.user == self
  end

  def can_access_StoryCard? story_card
    can_access_Project?(story_card.project)
  end

  def can_access_Activity? activity
    can_access_Timesheet? activity.timesheet
  end

  def can_access_Project? project
    can_access_Team?(project.team)
  end

  def can_access_StatementOfWork? sow
    self.statements_of_work.include?(sow)
  end

  def can_access_Team? team
    self.teams.include?(team)
  end

end