describe 'jobs/display.html.haml' do
  fixtures(:jobs)
  let(:job) { jobs('job_1') }

  before do
    assign_contract('jobs#display', :job, job)
    render_contract('jobs#display')
  end

  it 'displays the Job' do
  end
end
