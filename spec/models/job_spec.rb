require 'support/fixture_helpers'

describe Job do
  fixtures(:jobs)

  context 'instance attributes' do
    let(:job) { jobs(:job_1) }

    it 'has a name' do
      agree(job, :name).will eq('job 1')
    end
  end

  context 'class functions' do
    describe '.all' do
      let(:jobs) { all_fixtures(:jobs) }

      it 'returns all jobs' do
        agree(Job, :all).will eq(jobs)
      end
    end
  end
end
