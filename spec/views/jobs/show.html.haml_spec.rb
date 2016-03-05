describe 'jobs/show.html.haml' do
  fixtures(:jobs)
  let(:job) { jobs('job_1') }

  before do
    assign_contract('jobs#show', :job, job)
    render_contract('jobs#show')
  end

  it 'shows the Job' do
    contract 'job.name -> ""'
    contract 'job.status -> ""'
    
    expect(rendered).to include(job.name)
    expect(rendered).to include(job.status)
  end

  it 'links to the Job edit page' do
    assert_select 'a', href: edit_job_path(job)
  end
end