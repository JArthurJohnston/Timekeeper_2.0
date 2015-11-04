require_relative 'model_test_case'

class TeamMemberTest < ModelTestCase

  test 'create team member' do
    user = User.create
    team = Team.create

    member = TeamMember.create(user_id: user.id, team_id: team.id, is_admin: true)
    assert_equal user, member.user
    assert_equal team, member.team
    assert member.is_admin?
  end

  test 'creating a team member defaults is_admin to false' do
    member = TeamMember.create
    deny member.is_admin?
  end

end
