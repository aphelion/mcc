describe 'jobs/display.html.haml' do
  fixtures(:jobs)
  let(:job) { jobs('job_1') }

  before do
    assign_contract('jobs#display', :job, job)
    render_contract('jobs#display')
  end

  it 'renders the Job with the display partial' do
    contract 'jobs/_display renders job'
    expect(view).to have_rendered(partial: 'jobs/_display', locals: {job: job})
  end
end
