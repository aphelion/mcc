class BuildsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'builds'
  end

  def unsubscribed
  end
end
