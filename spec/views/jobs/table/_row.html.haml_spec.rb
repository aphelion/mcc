describe 'jobs/table/_row.html.haml' do
  fixtures(:jobs)

  def do_render(job)
    fulfill 'jobs/table/_row renders job'
    render partial: 'jobs/table/row', locals: {job: job}
  end

  context 'any Job' do
    let(:job) { jobs('job_1') }

    before do
      do_render(job)
    end

    describe 'Job text' do
      it 'renders a table row' do
        assert_select 'tr'
      end

      it 'shows the Job name' do
        contract 'job.name -> ""'
        assert_select 'tr td:nth-child(1)', {text: job.name}
      end

      it 'shows the Job status' do
        contract 'job.status -> ""'
        assert_select 'tr td:nth-child(2)', {text: job.status.humanize(capitalize: false)}
      end
    end

    describe 'Job actions' do
      it 'renders a link to the Job edit page' do
        assert_select 'tr td:nth-child(3) a', 'Edit', href: edit_job_path(job)
      end

      it 'renders a link to the Job show page' do
        assert_select 'tr td:nth-child(3) a', 'Launch', href: job_path(job)
      end

      it 'keeps the action buttons together' do
        assert_select 'tr td:nth-child(3).text-nowrap'
      end
    end
  end

  describe 'status colors' do
    context 'status is never run' do
      it 'renders the status in a grey label' do
        do_render(jobs('never_run'))
        assert_select 'tr td .label-default'
      end
    end

    context 'status is passed' do
      it 'renders the status in a green label' do
        do_render(jobs('passed'))
        assert_select 'tr td .label-success'
      end
    end

    context 'status is failed' do
      it 'renders the status in a red label' do
        do_render(jobs('failed'))
        assert_select 'tr td .label-danger'
      end
    end
  end

  describe 'live updating' do
    let(:job) { jobs('job_1') }

    it 'refreshes when the Job has updates' do
      contract 'data-job-table-row is kept up-to-date'
      do_render(job)
      assert_select 'tr[data-job-table-row=?]', job.id.to_s
    end
  end
end
