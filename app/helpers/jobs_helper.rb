module JobsHelper
  STATUS_HASH = {
      passed: 'success',
      failed: 'danger'
  }.with_indifferent_access

  def job_card_class(job)
    color = job_status_css_color(job.status)
    color ? 'card-' + color : ''
  end

  def job_status_label_class(job)
    color = job_status_css_color(job.status)
    'label-' + (color ? color : 'default')
  end

  def job_status_css_color(status)
    STATUS_HASH[status]
  end
end
