require 'support/fixture_helpers'

describe Job do
  fixtures(:jobs)
  let(:valid_attributes) do
    {name: 'a job'}
  end

  context 'instance attributes' do
    let(:job) { jobs(:job_1) }

    it 'has a name' do
      agree(job, :name).will eq('job 1')
    end
  end

  context 'class functions' do
    describe '.all' do
      let(:jobs) { all_fixtures(:jobs) }

      it 'returns all Jobs' do
        agree(Job, :all).will eq(jobs)
      end
    end

    describe '.new' do
      context 'with no parameters' do
        it 'returns a new Job' do
          agree(Job, :new).will be_a(Job)
        end
      end

      context 'with a hash' do
        it 'returns a new Job' do
          agree(Job, :new, valid_attributes).will be_a(Job)
        end
      end

    end

    describe '.create' do
      it 'creates a new Job' do
        expect {
          Job.create(valid_attributes)
        }.to change(Job, :count).by(1)
      end

      it 'returns a job' do
        agree(Job, :create, valid_attributes).will be_a(Job)
      end
    end
  end
end
