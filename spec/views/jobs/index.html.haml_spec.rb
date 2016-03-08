describe 'jobs/index.html.haml' do
  let(:jobs) { all_fixtures(:jobs) }

  before do
    assign_contract('jobs#index', :jobs, jobs)
    render_contract('jobs#index')
  end

  it 'renders all Jobs with the Job partial' do
    contract 'jobs/_job renders job'
    expect(view).to have_rendered(partial: 'jobs/_job', count: jobs.count)
  end

  it 'renders all Jobs in a table' do
    contract 'jobs/_table renders jobs'
    expect(view).to have_rendered(partial: 'jobs/_table', locals: {jobs: jobs})
  end

  it 'links to the new Job page' do
    assert_select 'a', 'New Job', href: new_job_path
  end
end
