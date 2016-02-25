require_relative '../../../../test/models/model_test_case'
require_relative '../../../models/date_test_helper'
class ProjectLineItemTest < ModelTestCase
  include DateTestHelper

  test 'initialize' do
    timesheet = Timesheet.new
    project = Project.new

    line_item = ProjectLineItem.new timesheet, project

    assert_equal timesheet, line_item.timesheet
    assert_equal project, line_item.project
  end

  test 'story cards' do
    timesheet = Timesheet.create
    project = Project.create
    card1 = StoryCard.create project_id: project.id
    card2 = StoryCard.create project_id: project.id
    StoryCard.create project_id: project.id
    Activity.create timesheet_id: timesheet.id, story_card_id: card1.id
    Activity.create timesheet_id: timesheet.id, story_card_id: card2.id

    line_item = ProjectLineItem.new timesheet, project

    assert_equal [card1, card2], line_item.story_cards
  end

  test 'csv' do
    timesheet = Timesheet.create
    sow = StatementOfWork.create client: 'Mickey'
    project = Project.create name: 'Mouse', statement_of_work_id: sow.id, code: 'SOW111'
    card1 = StoryCard.create project_id: project.id, number: '123'
    card2 = StoryCard.create project_id: project.id, number: '234'

    Activity.create timesheet_id: timesheet.id, story_card_id: card2.id, start_time: monday.at(4, 15), end_time: monday.at(5, 15)
    Activity.create timesheet_id: timesheet.id, story_card_id: card1.id, start_time: tuesday.at(4, 15), end_time: tuesday.at(5, 15)

    line_item = ProjectLineItem.new timesheet, project

    expected_csv = 'Mickey,SOW111,Mouse DEV - 123,,,,1.0,,,,
Mickey,SOW111,Mouse DEV - 234,,,1.0,,,,,
'

    assert_equal expected_csv, line_item.to_csv
  end

  test 'line item for' do
    timesheet = Timesheet.create
    sow = StatementOfWork.create client: 'Mickey'
    project = Project.create name: 'Mouse', statement_of_work_id: sow.id, code: 'SOW111'
    card1 = StoryCard.create project_id: project.id, number: '123'
    card2 = StoryCard.create project_id: project.id, number: '234'

    Activity.create timesheet_id: timesheet.id, story_card_id: card2.id, start_time: monday.at(4, 15), end_time: monday.at(5, 15)
    Activity.create timesheet_id: timesheet.id, story_card_id: card1.id, start_time: tuesday.at(4, 15), end_time: tuesday.at(5, 15)

    line_item = ProjectLineItem.new timesheet, project

    expected_csv = 'Mickey,SOW111,Mouse DEV - 123,,,,1.0,,,,
Mickey,SOW111,Mouse DEV - 234,,,1.0,,,,,
'

    assert_equal expected_csv, ProjectLineItem.line_item_for(timesheet, project)

  end

end