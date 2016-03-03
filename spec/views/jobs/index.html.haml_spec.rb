describe 'jobs/index.html.haml' do
  let(:job) { double(:job) }
  let(:jobs) { [job, job] }

  before do
    stipulate(job).must receive(:name).and_return('job name')
    assign_contract('jobs#index', :jobs, jobs)
    render_contract('jobs#index')
  end

  it 'lists all jobs' do
    expect(rendered).to include('job name')
  end
end
