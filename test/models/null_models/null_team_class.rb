require_relative '../model_test_case'

class NullTeamClass < ModelTestCase

  test 'returns null fields' do
    null_team = Team::NULL

    assert_equal -1, null_team.id
    assert_empty null_team.team_members
    assert_empty null_team.projects
  end

end