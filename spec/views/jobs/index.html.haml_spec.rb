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
      assert_select 'a', text: 'Edit', href: edit_job_path(job)
      assert_select 'a', text: 'Display', href: display_job_path(job)
    end
  end
end
