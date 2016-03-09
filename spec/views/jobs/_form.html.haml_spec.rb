describe 'jobs/_form.html.haml' do
  fixtures(:jobs)
  let(:statuses) { ['passed', 'failed'] }

  it { fulfill 'jobs/_form renders job form' }

  describe 'basic form composition' do
    let(:job) { jobs(:job_1) }
    before do
      render partial: 'jobs/form', locals: {job: job, statuses: statuses}
    end

    it 'renders a pre-populated input for name' do
      assert_select 'input#job_name[value=?]', job.name
    end

    it 'renders a pre-selected select for status' do
      assert_select 'select#job_status'
      statuses.each do |status|
        assert_select 'select#job_status option[value=?]', status, {text: status.humanize(capitalize: false)}
      end
      assert_select 'select#job_status option[selected][value=?]', 'passed'
    end

    it 'renders a submit button' do
      assert_select 'input[type=?]', 'submit'
    end
  end

  describe 'cancel button' do
    let(:job) { jobs(:job_1) }
    context 'when cancel_path is supplied' do
      it 'renders a cancel button' do
        render partial: 'jobs/form', locals: {job: job, statuses: statuses, cancel_path: job_path(job)}
        assert_select 'a', 'Cancel', href: job_path(job)
      end
    end

    context 'when cancel_path is not supplied' do
      it 'does not render a cancel button' do
        render partial: 'jobs/form', locals: {job: job, statuses: statuses}
        assert_select 'a', {text: 'Cancel', count: 0}
      end
    end
  end

  context 'when Job is new' do
    let(:job) { Job.new }

    before do
      render partial: 'jobs/form', locals: {job: job, statuses: statuses}
    end

    it 'submits POST to jobs' do
      assert_select 'form[action=?][method=?]', jobs_path, 'post'
    end

    it 'does not render a delete button' do
      assert_select 'a', {text: 'Delete', count: 0}
    end
  end

  context 'when Job already exists' do
    let(:job) { jobs(:job_1) }

    before do
      render partial: 'jobs/form', locals: {job: job, statuses: statuses}
    end

    it 'submits POST to job' do
      assert_select 'form[action=?][method=?]', job_path(job), 'post'
    end

    it 'renders a delete button' do
      contract 'DELETE /jobs/#'
      assert_select 'a', 'Delete', {method: :delete, href: job_path(job)}
    end
  end
end
