require_relative '../../model_test_case'
require_relative '../../../models/date_test_helper'

class StoryCardLineItemTest < ModelTestCase
  include DateTestHelper

  test 'initializes from timesheet and story card' do
    sheet = Timesheet.new
    card = StoryCard.new

    card_line_item = StoryCardLineItem.new(sheet, card)

    assert_equal sheet, card_line_item.timesheet
    assert_equal card, card_line_item.story_card
  end

  test 'gets timesheet activities for story card' do
    sheet = Timesheet.create
    card = StoryCard.create
    act1 = Activity.create(timesheet_id: sheet.id, story_card_id: card.id)
    act2 = Activity.create(timesheet_id: sheet.id, story_card_id: card.id)
    act3 = Activity.create(timesheet_id: sheet.id, story_card_id: card.id)

    card_line_item = StoryCardLineItem.new(sheet, card)

    assert_equal [act1, act2, act3], card_line_item.activities
  end

  test 'activities on a date' do
    sheet = Timesheet.create
    card = StoryCard.create
    start_time = DateTime.new(2015, 1, 1, 5, 45, 0)
    act1 = Activity.create(timesheet_id: sheet.id, story_card_id: card.id, start_time: start_time)
    act2 = Activity.create(timesheet_id: sheet.id, story_card_id: card.id, start_time: start_time)
    Activity.create(timesheet_id: sheet.id, story_card_id: card.id, start_time: DateTime.new(2015, 1, 2, 5, 45, 0))

    card_line_item = StoryCardLineItem.new(sheet, card)

    assert_equal [act1, act2], card_line_item.activities_on(start_time)
  end

  test 'line item string' do
    sow = StatementOfWork.create(client: 'Mickey')
    project = Project.create(name: 'Mouse', code: 'SOW456')
    JobIdentifier.create(statement_of_work_id: sow.id, project_id: project.id)
    sheet = Timesheet.create
    card = StoryCard.create(project_id: project.id, number: '123')
    start_time = monday.at(5, 45)
    Activity.create(timesheet_id: sheet.id, story_card_id: card.id, start_time: start_time, end_time: monday.at(7, 15))
    Activity.create(timesheet_id: sheet.id, story_card_id: card.id, start_time: monday.at(8), end_time: monday.at(9))
    card_line_item = StoryCardLineItem.new(sheet, card)

    assert_equal 'Mickey,SOW456,Mouse DEV - 123,,,2.5,,,,,', card_line_item.to_csv
  end

  test 'line item for' do
    sow = StatementOfWork.create(client: 'Mickey')
    project = Project.create(name: 'Mouse', code: 'SOW456')
    JobIdentifier.create(statement_of_work_id: sow.id, project_id: project.id)
    sheet = Timesheet.create
    card = StoryCard.create(project_id: project.id, number: '123')
    start_time = monday.at(5, 45)
    Activity.create(timesheet_id: sheet.id, story_card_id: card.id, start_time: start_time, end_time: monday.at(7, 15))
    Activity.new(timesheet_id: sheet.id, story_card_id: card.id, start_time: monday.at(8), end_time: monday.at(9))

    assert_equal 'Mickey,SOW456,Mouse DEV - 123,,,2.5,,,,,', StoryCardLineItem.line_item_for(sheet, card)
  end
end