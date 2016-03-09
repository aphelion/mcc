class JobsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'jobs'
  end

  def unsubscribed
  end
end
