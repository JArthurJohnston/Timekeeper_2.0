class Project < ActiveRecord::Base
  include ProjectDisplay
  include HasUserAccess
  extend FindNullModel

  has_many :job_identifiers
  has_many :story_cards, -> {order(:number)}
  belongs_to :user
  belongs_to :team

  NULL = NullProject.new

  def statement_of_work_for user
    sows = StatementOfWork.joins(:job_identifiers).where(statements_of_work: {user_id: user.id})
    sows.empty? ? StatementOfWork::NULL : sows[0]
  end

  def create_basic_story_cards
    [
        ['STU', 'Stand Up'],
        ['KIK', 'Kick Off'],
        ['SHO', 'Show and Tell'],
        ['SHP', 'Show and Tell Prep'],
        ['EST', 'Estimation'],
        ['MCR', 'Manage Client Communications'],
        ['PLG', 'Planning Game']
    ].each do
      |number, title|
      StoryCard.create(number: number, title: title, project_id: self.id)
    end
  end

end
