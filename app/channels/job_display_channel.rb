class JobDisplayChannel < ApplicationCable::Channel
  def subscribed
    stream_from "job_display_#{params[:job]}"
  end

  def unsubscribed
  end
end
