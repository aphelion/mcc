class Job < ApplicationRecord
  enum status: [:passed, :failed]
end
