class Job < ApplicationRecord
  enum status: [:never_run, :passed, :failed]

  after_update_commit { JobUpdateBroadcastJob.perform_later self }
  after_destroy_commit { JobDestroyBroadcastJob.perform_later self.id }
end
