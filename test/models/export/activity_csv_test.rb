require_relative '../model_test_case'

class ActivityCSVTest < ModelTestCase

  test 'activity to csv' do
    sow = StatementOfWork.create
    project = Project.create(statement_of_work_id: sow.id)
    story = StoryCard.create(project_id: project.id)
    act = Activity.create(story_card_id: story.id)

    assert_equal '', act.to_csv
  end
end