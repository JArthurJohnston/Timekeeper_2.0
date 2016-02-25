class Team < ActiveRecord::Base
  has_many :team_members
  has_many :projects
  belongs_to :user

  # def self.create attributes = nil, &block
    # created_team  = super
    # unless attributes.nil?
    #   TeamMember.create(user_id: attributes[:user_id], team_id: created_team.id, is_admin: true)
    # end
    # created_team
  # end

  def members
    User.joins(:team_members).where(team_members: {team_id: self.id})
  end

end
