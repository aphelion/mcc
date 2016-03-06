module JobsHelper
  def display_status_class(job)
    case job.status
      when 'passed'
        'card-success'
      when 'failed'
        'card-danger'
      else
        ''
    end
  end
end
