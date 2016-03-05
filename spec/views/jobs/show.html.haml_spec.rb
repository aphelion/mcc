describe 'jobs/show.html.haml' do
  fixtures(:jobs)
  let(:job) { jobs('job_1') }

  before do
    assign_contract('jobs#show', :job, job)
    render_contract('jobs#show')
  end

  it 'shows the Job' do
    expect(rendered).to include(job.name)
  end
end
