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
    sow.user == self
  end

  def can_access_Team? team
    self.teams.include?(team) || team.user == self
  end

end