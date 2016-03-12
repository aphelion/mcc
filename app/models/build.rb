class Build < ApplicationRecord
  enum status: [:never_run, :passed, :failed]

  after_create_commit { BuildCreateBroadcastJob.perform_later self }
  after_update_commit { BuildUpdateBroadcastJob.perform_later self }
  after_destroy_commit { BuildDestroyBroadcastJob.perform_later self.id }
end
