require_relative 'model_test_case'

class TeamTest < ModelTestCase

  test 'create team' do
    user = create_user
    expected_name = 'team awesome'

    team = Team.create(user_id: user.id, name: expected_name)

    assert_equal expected_name, team.name
    assert_equal user, team.user
  end

  test 'creating a team creates admin team member for team owner' do
    user = create_user
    team = Team.create(user_id: user.id)

    user_team_admin = TeamMember.find_by(user_id: user.id, team_id: team.id)
    assert_not_nil user_team_admin
    assert user_team_admin.is_admin?

    assert_not_nil user_team_admin.team_id
    assert_equal team, user_team_admin.team
    assert_equal user, user_team_admin.user
  end

  test 'teams have members' do
    creator = create_user
    user1 = create_user
    user2 = create_user

    team1 = Team.create(user_id: creator.id)
    TeamMember.create(team_id: team1.id, user_id: user1.id)
    TeamMember.create(team_id: team1.id, user_id: user2.id)

    members1 = team1.members
    assert_equal 3, members1.size
    assert members1.include?(creator)
    assert members1.include?(user1)
    assert members1.include?(user2)

    creator2 = create_user
    user3 = create_user
    team2 = Team.create(user_id: creator2.id)
    TeamMember.create(user_id: user3.id, team_id: team2.id)
    TeamMember.create(user_id: user2.id, team_id: team2.id)

    members2 = team2.members
    assert_equal 3, members2.size
    assert members2.include? creator2
    assert members2.include? user3
    assert members2.include? user2
  end

  test 'team has projects' do
    team = Team.create

    assert_empty team.projects

    project1 = Project.create(team_id: team.id)
    project2 = Project.create(team_id: team.id)

    team_projects = team.projects
    assert_equal 2, team_projects.size
    assert team_projects.include? project1
    assert team_projects.include? project2
  end

  test 'display string' do
    team = Team.create(name: 'Mouse')

    assert_equal 'Mouse', team.display_string
  end

  test 'display json' do
    user = create_user
    team = Team.create(name: 'Mouse', user_id: user.id)

    expected_json = %"{\"id\":%{team_id},\"user_id\":%{user_id},\"name\":\"Mouse\"}" % {user_id: user.id, team_id: team.id}
    assert_equal expected_json, team.to_json
  end

end
