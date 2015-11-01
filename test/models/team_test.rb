require_relative 'model_test_case'

class TeamTest < ModelTestCase

  test 'create team' do
    user = User.create
    expected_name = 'team awesome'

    team = Team.create(user_id: user.id, name: expected_name)

    assert_equal expected_name, team.name
    assert_equal user, team.user
  end

end
