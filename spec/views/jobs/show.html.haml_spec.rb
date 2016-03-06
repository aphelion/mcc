describe 'jobs/show.html.haml' do
  fixtures(:jobs)
  let(:job) { jobs('job_1') }

  before do
    assign_contract('jobs#show', :job, job)
    render_contract('jobs#show')
  end

  it 'renders the Job with its partial' do
    contract 'jobs/_job renders job'
    expect(view).to have_rendered(partial: 'jobs/_job', locals: {job: job})
  end
end
