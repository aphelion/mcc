describe 'jobs/new.html.haml' do
  let(:job) { Job.new }

  before do
    assign_contract('jobs#new', :job, job)
    render_contract('jobs#new')
  end

  describe 'form composition' do
    it 'renders an input for name' do
      assert_select 'input#job_name'
    end

    it 'renders a submit button' do
      assert_select 'input[type=?]', 'submit'
    end

    it 'submits POST to jobs' do
      fulfill 'POST -> jobs#create'
      assert_select 'form[action=?][method=?]', jobs_path, 'post'
    end
  end
end
