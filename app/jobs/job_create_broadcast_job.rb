class JobCreateBroadcastJob < ApplicationJob
  queue_as :default

  def perform(job)
    ActionCable.server.broadcast 'jobs',
                                 event: 'create',
                                 html: {job: render_job(job), job_table_row: render_job_table_row(job)}
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
