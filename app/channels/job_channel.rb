class JobChannel < ApplicationCable::Channel
  def subscribed
    stream_from "job_#{params[:job]}"
  end

  def unsubscribed
  end
end
