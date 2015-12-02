require_relative '../../model_test_case'

class StoryCardLineItemTest < ModelTestCase

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
    act3 = Activity.create(timesheet_id: sheet.id, story_card_id: card.id, start_time: DateTime.new(2015, 1, 2, 5, 45, 0))

    card_line_item = StoryCardLineItem.new(sheet, card)

    assert_equal [act1, act2], card_line_item.activities_on(start_time)

  end
end