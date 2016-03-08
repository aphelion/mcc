class JobUpdateBroadcastJob < ApplicationJob
  queue_as :default

  def perform(job)
    ActionCable.server.broadcast "job_display_#{job.id}",
                                 event: 'update',
                                 html: render_job_display(job)
    ActionCable.server.broadcast "job_#{job.id}",
                                 event: 'update',
                                 html: {job: render_job(job), job_table_row: render_job_table_row(job)}
  end

  private
  def render_job_display(job)
    ApplicationController.renderer.render(partial: 'jobs/display', locals: {job: job})
  end

  private
  def render_job(job)
    ApplicationController.renderer.render(partial: 'jobs/job', locals: {job: job})
  end

  private
  def render_job_table_row(job)
    ApplicationController.renderer.render(partial: 'jobs/table/row', locals: {job: job})
  end
end
