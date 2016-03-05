describe 'jobs/index.html.haml' do
  let(:jobs) { all_fixtures(:jobs) }

  before do
    assign_contract('jobs#index', :jobs, jobs)
    render_contract('jobs#index')
  end

  it 'lists all Jobs' do
    contract 'job.name -> ""'

    jobs.each do |job|
      expect(rendered).to include(job.name)
    end
  end

  it 'links to all Jobs' do
    jobs.each do |job|
      assert_select 'a', text: job.name, href: job
    end
  end
end
