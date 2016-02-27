class Team < ActiveRecord::Base
  include TeamDisplay
  has_many :team_members
  has_many :projects
  belongs_to :user

  def members
    User.joins(:team_members).where(team_members: {team_id: self.id})
  end

end
