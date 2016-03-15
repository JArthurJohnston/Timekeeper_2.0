require_relative '../model_test_case'

class UserAccessAdminTest < ModelTestCase

  def create_user
    password = rand(1000).to_s
    User.create(password: password, password_confirmation: password)
  end

  def setup
    @user = create_user
  end

  test 'user has access to timesheet' do
    user_sheet = Timesheet.create(user_id: @user.id)

    other_sheet = Timesheet.create()
    assert user_sheet.accessable_by?(@user)
    refute other_sheet.accessable_by?(@user)
  end

  test 'user has access to activity' do
    user_sheet = Timesheet.create(user_id: @user.id)
    other_sheet = Timesheet.create()
    user_act = Activity.create(timesheet_id: user_sheet.id)
    other_act = Activity.create(timesheet_id: other_sheet.id)

    assert user_act.accessable_by?(@user)
    refute other_act.accessable_by?(@user)
  end

  test 'user has access to story card' do
    user_team = Team.create
    other_team = Team.create
    TeamMember.create(user_id: @user.id, team_id: user_team.id)
    user_project = Project.create(team_id: user_team.id)
    other_project = Project.create(team_id: other_team.id)
    user_card = StoryCard.create(project_id: user_project.id)
    other_card = StoryCard.create(project_id: other_project.id)

    assert user_card.accessable_by?(@user)
    refute other_card.accessable_by?(@user)
  end

  test 'user has access to statement of work' do
    other_user = create_user
    user_sow = StatementOfWork.create(user_id: @user.id)
    other_sow = StatementOfWork.create(user_id: other_user.id)

    assert user_sow.accessable_by?(@user)
    refute other_sow.accessable_by?(@user)
  end

  test 'user has access to project' do
    user_team = Team.create
    other_team = Team.create
    TeamMember.create(user_id: @user.id, team_id: user_team.id)
    user_project = Project.new(team_id: user_team.id)
    other_project = Project.new(team_id: other_team.id)

    assert user_project.accessable_by?(@user)
    refute other_project.accessable_by?(@user)
  end

  test 'user has access to team' do
    user_team = Team.create
    other_team = Team.create
    TeamMember.create(user_id: @user.id, team_id: user_team.id)

    assert user_team.accessable_by?(@user)
    refute other_team.accessable_by?(@user)
  end

  test 'user has access to team he created even without team member' do
    team = Team.create(user_id: @user.id)

    assert team.accessable_by?(@user)
  end
end