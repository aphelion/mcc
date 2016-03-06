describe 'jobs/new.html.haml' do
  let(:job) { Job.new }
  let(:statuses) { ['passed', 'failed'] }

  before do
    assign_contract('jobs#new', :job, job)
    assign_contract('jobs#new', :statuses, statuses)
    render_contract('jobs#new')
  end

  describe 'form composition' do
    it 'renders an input for name' do
      assert_select 'input#job_name'
    end

    it 'renders a select for status' do
      assert_select 'select#job_status'
      statuses.each do |status|
        assert_select 'select#job_status option[value=?]', status, {text: status.humanize(capitalize: false)}
      end
    end

    it 'renders a submit button' do
      assert_select 'input[type=?]', 'submit'
    end

    it 'renders a cancel button' do
      assert_select 'a', 'Cancel', href: jobs_path
    end

    it 'submits POST to jobs' do
      fulfill 'POST -> jobs#create'
      assert_select 'form[action=?][method=?]', jobs_path, 'post'
    end
  end
end
