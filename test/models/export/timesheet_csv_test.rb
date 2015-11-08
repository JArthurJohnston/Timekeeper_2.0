require_relative '../model_test_case'
require_relative '../../../test/models/date_test_helper'

class TimesheetCSVTest < ModelTestCase
  include DateTestHelper

  test 'to csv' do
    sow = StatementOfWork.create(client: 'Mickey')
    project = Project.create(name: 'Mouse', job_id: 'SOW456', statement_of_work_id: sow.id, billable: true)
    card = StoryCard.create(project_id: project.id, number: '123')
    timesheet = Timesheet.create()
    Activity.create(start_time: monday.at(8, 30),
                    end_time: monday.at(11, 45),
                    timesheet_id: timesheet.id,
                    story_card_id: card.id)
    Activity.create(start_time: friday.at(13, 30),
                    end_time: friday.at(15, 45),
                    timesheet_id: timesheet.id,
                    story_card_id: card.id)

    assert_equal 'Mickey,SOW456,Mouse DEV - 123,Y,Y,,,3.25,,,,2.25,
', timesheet.to_csv
  end

  test 'to csv with only one activity' do
    sow = StatementOfWork.create(client: 'Mickey')
    project = Project.create(name: 'Mouse', job_id: 'SOW456', statement_of_work_id: sow.id, billable: true)
    card = StoryCard.create(project_id: project.id, number: '123')
    timesheet = Timesheet.create()
    Activity.create(start_time: monday.at(8, 30),
                    end_time: monday.at(11, 45),
                    timesheet_id: timesheet.id,
                    story_card_id: card.id)

    assert_equal 'Mickey,SOW456,Mouse DEV - 123,Y,Y,,,3.25,,,,,
', timesheet.to_csv
  end

  test 'different cards on the same day' do
    sow = StatementOfWork.create(client: 'Mickey')
    project = Project.create(name: 'Mouse', job_id: 'SOW456', statement_of_work_id: sow.id, billable: true)
    card1 = StoryCard.create(project_id: project.id, number: '123')
    card2 = StoryCard.create(project_id: project.id, number: '234')
    timesheet = Timesheet.create()
    Activity.create(start_time: monday.at(8, 30),
                    end_time: monday.at(11, 45),
                    timesheet_id: timesheet.id,
                    story_card_id: card1.id)
    Activity.create(start_time: monday.at(8, 30),
                    end_time: monday.at(11, 45),
                    timesheet_id: timesheet.id,
                    story_card_id: card2.id)

    expected_csv = 'Mickey,SOW456,Mouse DEV - 123,Y,Y,,,3.25,,,,,
Mickey,SOW456,Mouse DEV - 234,Y,Y,,,3.25,,,,,
'
    assert_equal expected_csv, timesheet.to_csv
  end

  test 'to csv with only no activities' do
    sow = StatementOfWork.create(client: 'Mickey')
    project = Project.create(name: 'Mouse', job_id: 'SOW456', statement_of_work_id: sow.id)
    card = StoryCard.create(project_id: project.id, number: '123')
    timesheet = Timesheet.create()

    assert_equal '', timesheet.to_csv
  end

  test 'to csv with multiple cards and activities' do
    sow = StatementOfWork.create(client: 'Mickey')
    project = Project.create(name: 'Mouse', job_id: 'SOW456', statement_of_work_id: sow.id, billable: true)
    card1 = StoryCard.create(project_id: project.id, number: '123')
    card2 = StoryCard.create(project_id: project.id, number: '124')
    timesheet = Timesheet.create()
    Activity.create(start_time: monday.at(8, 30),
                    end_time: monday.at(11, 45),
                    timesheet_id: timesheet.id,
                    story_card_id: card1.id)
    Activity.create(start_time: friday.at(13, 30),
                    end_time: friday.at(15, 45),
                    timesheet_id: timesheet.id,
                    story_card_id: card1.id)
    Activity.create(start_time: tuesday.at(8, 30),
                    end_time: tuesday.at(11, 45),
                    timesheet_id: timesheet.id,
                    story_card_id: card2.id)
    Activity.create(start_time: thursday.at(13, 30),
                    end_time: thursday.at(15, 45),
                    timesheet_id: timesheet.id,
                    story_card_id: card2.id)

    expected_csv = 'Mickey,SOW456,Mouse DEV - 123,Y,Y,,,3.25,,,,2.25,
Mickey,SOW456,Mouse DEV - 124,Y,Y,,,,3.25,,2.25,,
'
    assert_equal expected_csv, timesheet.to_csv
  end

end