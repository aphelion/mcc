describe 'jobs/index.html.haml' do
  let(:jobs) { all_fixtures(:jobs) }

  before do
    assign_contract('jobs#index', :jobs, jobs)
    render_contract('jobs#index')
  end

  it 'renders all Jobs with the Job partial' do
    contract '_job renders job'
    expect(view).to have_rendered(partial: '_job', count: jobs.count)
  end

  it 'links to the new Job page' do
    assert_select 'a', 'New Job', href: new_job_path
  end
end
