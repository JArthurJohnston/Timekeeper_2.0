require_relative 'model_test_case'

class ProjectTest < ModelTestCase

  test 'project fields' do
    expected_project_name = 'Mouse'
    expected_project_code = 'SOW1234'
    team = Team.create
    project = Project.create(name: expected_project_name, team_id: team.id, code: expected_project_code)

    assert_empty project.job_identifiers
    assert_empty project.story_cards
    assert_equal expected_project_name, project.name
    assert_equal expected_project_code, project.code
    assert_equal team, project.team
  end

  test 'project has job identifiers' do
    project = Project.create()
    assert_empty project.job_identifiers

    job1 = JobIdentifier.create(project_id: project.id)
    job2 = JobIdentifier.create(project_id: project.id)
    job3 = JobIdentifier.create(project_id: project.id + 354)

    assert_equal 2, project.job_identifiers.size
    assert project.job_identifiers.include? job1
    assert project.job_identifiers.include? job2
    refute project.job_identifiers.include? job3
  end

  test 'project has story cards' do
    project = Project.create()

    assert_empty project.story_cards

    storyCard1 = StoryCard.create(number:'1',title: '', description: '', project_id: project.id)
    storyCard2 = StoryCard.create(number:'2',title: '', description: '', project_id: project.id)

    assert_equal 2, project.story_cards.size
    assert project.story_cards.include? storyCard1
    assert project.story_cards.include? storyCard2
  end

  test 'story cards are sorted by number' do
    project = Project.create()
    storyCard1 = StoryCard.create(number:'001', project_id: project.id)
    storyCard2 = StoryCard.create(number:'201', project_id: project.id)
    storyCard3 = StoryCard.create(number:'010', project_id: project.id)
    storyCard4 = StoryCard.create(number:'ab2', project_id: project.id)

    assert_equal [storyCard1, storyCard3, storyCard2, storyCard4], project.story_cards
  end

  test 'project belongs to a user' do
    user = User.create
    project = Project.create(user_id: user.id)

    assert_equal user, project.user
  end

  test 'statement of work for user' do
    user = User.create
    project = Project.create()
    sow = StatementOfWork.create(user_id: user.id)

    assert_equal StatementOfWork::NULL, project.statement_of_work_for(user)

    JobIdentifier.create(statement_of_work_id: sow.id, project_id: project.id)

    assert_equal sow, project.statement_of_work_for(user)
  end

  test 'creating basic story cards' do
    project = Project.create

    assert_empty project.story_cards

    project.create_basic_story_cards

    basic_story_cards = project.story_cards
    assert_equal 7, basic_story_cards.size
  end

end
