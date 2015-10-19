class StoryCard < ActiveRecord::Base
  include StoryCardDisplay
  belongs_to :project
  has_many :activities, -> {order(:start_time)}

  NULL = NullStoryCard.new

  def billable_hours
    billable_hours = 0.0
    self.activities.each do
      |eachActivity|
      unless eachActivity.total_time.eql? Float::INFINITY
        billable_hours += eachActivity.total_time
      end
    end
    return billable_hours
  end

end
