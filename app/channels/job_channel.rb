class BuildChannel < ApplicationCable::Channel
  def subscribed
    stream_from "build_#{params[:build]}"
  end

  def unsubscribed
  end
end
