require_relative 'model_test_case'

class ProjectTest < ModelTestCase

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

  test 'project fields' do
    expected_sow_number = 'GT123'
    expected_PO_number = 'HY345'
    expected_client = 'Mickey'
    expected_project_name = 'Mouse'
    sow = StatementOfWork.create(number: expected_sow_number, purchase_order_number: expected_PO_number, client: expected_client)
    project = Project.create(name: expected_project_name)
    job_id = JobId.create(statement_of_work_id: sow.id, project_id: project.id)

    assert project.job_ids.include?(job_id)
    assert_equal expected_sow_number, project.invoice_number
    assert_equal expected_client, project.client
    assert_equal expected_PO_number, project.purchase_order_number
    assert_equal sow, project.statement_of_work
    assert_equal expected_project_name, project.name
  end

  test 'project belongs to a user' do
    user = User.create
    project = Project.create(user_id: user.id)

    assert_equal user, project.user
  end

  test ':statement_of_work returns null sow when sow_id is nil' do
    user = User.create
    project = Project.create(user_id: user.id)

    assert_equal StatementOfWork::NULL, project.statement_of_work

    sow = StatementOfWork.create
    project = Project.create(statement_of_work_id: sow.id)

    assert_equal sow, project.statement_of_work
  end

end
