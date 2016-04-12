class NullTeam < Team
  include NullModel

  def team_members
    []
  end

  def projects
    []
  end

end