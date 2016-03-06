class Job < ApplicationRecord
  enum status: [:never_run, :passed, :failed]
end
