class JobDestroyBroadcastJob < ApplicationJob
  queue_as :default

  def perform(job_id)
    ActionCable.server.broadcast "job_#{job_id}",
                                 event: 'destroy'
  end
end
