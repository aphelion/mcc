describe 'jobs/_job.html.haml' do
  fixtures(:jobs)
  let(:job) { jobs('job_1') }

  before do
    fulfill '_job renders job'
    render partial: 'job', locals: {job: job}
  end

  it 'shows the Job data' do
    contract 'job.name -> ""'
    contract 'job.status -> ""'

    expect(rendered).to include(job.name)
    expect(rendered).to include(job.status.humanize(capitalize: false))
  end

  it 'links to the Job edit page' do
    assert_select 'a', 'Edit', href: edit_job_path(job)
  end

  it 'links to the Job display page' do
    assert_select 'a', 'Display', href: display_job_path(job)
  end
end
