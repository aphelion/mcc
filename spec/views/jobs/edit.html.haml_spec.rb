describe 'jobs/edit.html.haml' do
  fixtures(:jobs)
  let(:job) { jobs(:job_1) }
  let(:statuses) { ['passed', 'failed'] }

  before do
    assign_contract('jobs#edit', :job, job)
    assign_contract('jobs#edit', :statuses, statuses)
    render_contract('jobs#edit')
  end

  describe 'form composition' do
    it 'renders a pre-populated input for name' do
      assert_select 'input#job_name[value=?]', job.name
    end

    it 'renders a pre-selected select for status' do
      assert_select 'select#job_status'
      assert_select 'select#job_status option[selected][value=?]', 'passed'
    end

    it 'renders a submit button' do
      assert_select 'input[type=?]', 'submit'
    end

    it 'submits POST to job' do
      fulfill 'POST -> jobs#create'
      assert_select 'form[action=?][method=?]', job_path(job), 'post'
    end
  end
end
