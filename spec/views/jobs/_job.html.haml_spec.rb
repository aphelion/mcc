describe 'jobs/_job.html.haml' do
  fixtures(:jobs)

  def do_render(job)
    fulfill '_job renders job'
    render partial: 'job', locals: {job: job}
  end

  context 'any Job' do
    let(:job) { jobs('job_1') }

    before do
      do_render(job)
    end

    describe 'show Job information' do
      it 'shows the Job name' do
        contract 'job.name -> ""'
        expect(rendered).to include(job.name)
      end

      it 'shows the Job status' do
        contract 'job.status -> ""'
        expect(rendered).to include(job.status.humanize(capitalize: false))
      end
    end

    describe 'Job links' do
      it 'links to the Job edit page' do
        assert_select 'a', 'Edit', href: edit_job_path(job)
      end

      it 'links to the Job display page' do
        assert_select 'a', 'Display', href: display_job_path(job)
      end
    end
  end

  describe 'status colors' do
    context 'status is never run' do
      it 'shows the status in a grey label' do
        do_render(jobs('never_run'))
        assert_select '.label-default'
      end
    end

    context 'status is passed' do
      it 'shows the status in a green label' do
        do_render(jobs('passed'))
        assert_select '.label-success'
      end
    end

    context 'status is failed' do
      it 'shows the status in a red label' do
        do_render(jobs('failed'))
        assert_select '.label-danger'
      end
    end
  end
end
