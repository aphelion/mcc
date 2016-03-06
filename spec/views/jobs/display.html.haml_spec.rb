describe 'jobs/display.html.haml' do
  fixtures(:jobs)

  def do_render(job)
    assign_contract('jobs#display', :job, job)
    render_contract('jobs#display')
  end

  describe 'display metadata' do
    let(:job) { jobs('job_1') }

    it 'displays the Job name' do
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
end
