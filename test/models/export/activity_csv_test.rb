require_relative '../model_test_case'
require_relative 'date_test_helper'

class ActivityCSVTest < ModelTestCase
  include DateTestHelper

  test 'activity to csv' do
    story = StoryCard.create(project_id: project.id)
    act = Activity.create(story_card_id: story.id)

    assert_equal '', act.to_csv
  end
end