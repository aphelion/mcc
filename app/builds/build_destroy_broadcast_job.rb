class BuildDestroyBroadcastJob < ApplicationJob
  queue_as :default

  def perform(build_id)
    ActionCable.server.broadcast "build_#{build_id}",
                                 event: 'destroy'
  end
end
