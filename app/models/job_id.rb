class JobId < ActiveRecord::Base
  belongs_to :statement_of_work
  belongs_to :project
end
