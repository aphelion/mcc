describe 'jobs/_job.html.haml' do
  fixtures(:jobs)

  def do_render(job)
    fulfill 'jobs/_job renders job'
    render partial: 'jobs/job', locals: {job: job}
  end

  describe 'Job text' do
    let(:job) { jobs('job_1') }

    it 'renders the Job name' do
      do_render(job)
      expect(rendered).to include(job.name)
    end
  end

  describe 'color' do
    context 'when the build passed' do
      it 'is green' do
        do_render(jobs('passed'))
        assert_select '.card-success'
      end
    end

    context 'when the build failed' do
      it 'is red' do
        do_render(jobs('failed'))
        assert_select '.card-danger'
      end
    end

    context 'when the has never run' do
      it 'is white' do
        do_render(jobs('never_run'))
        assert_select '.card-success', {count: 0}
        assert_select '.card-danger', {count: 0}
      end
    end
  end

  describe 'live updating' do
    let(:job) { jobs('job_1') }

    it 'refreshes when the Job has updates' do
      contract 'data-job is kept up-to-date'
      do_render(job)
      assert_select '[data-job=?]', job.id.to_s
    end
  end
end
