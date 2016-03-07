describe 'jobs/edit.html.haml' do
  fixtures(:jobs)
  let(:job) { jobs(:job_1) }
  let(:statuses) { ['passed', 'failed'] }

  before do
    assign_contract('jobs#edit', :job, job)
    assign_contract('jobs#edit', :statuses, statuses)
    render_contract('jobs#edit')
  end

  it { contract 'jobs/_display renders job' }

  it 'renders a form for the Job' do
    expect(view).to have_rendered(partial: 'form', locals: {job: job, statuses: statuses, cancel_path: jobs_path})
  end
end
