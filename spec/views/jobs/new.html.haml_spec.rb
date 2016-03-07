describe 'jobs/new.html.haml' do
  let(:job) { Job.new }
  let(:statuses) { ['passed', 'failed'] }

  before do
    assign_contract('jobs#new', :job, job)
    assign_contract('jobs#new', :statuses, statuses)
    render_contract('jobs#new')
  end

  it { contract 'jobs/_display renders job' }

  it 'renders a form for the Job' do
    expect(view).to have_rendered(partial: 'form', locals: {job: job, statuses: statuses, cancel_path: jobs_path})
  end
end
