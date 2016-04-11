module TeamAccessableFields

  def story_cards
    # this is VERY inneficient...
    projects.collect { |e| e.story_cards }.flatten
  end

  def projects
    # Re-do this in sql...
    teams.collect { |e| e.projects }.flatten
  end

  def teams
    Team.joins(:team_members).where(team_members: {user_id: self.id})
  end

end
