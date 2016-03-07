require 'support/fixture_helpers'
require 'support/job_attributes'

describe Job do
  fixtures(:jobs)
  let(:valid_attributes) { JobAttributes.valid_attributes }
  let(:statuses) { JobAttributes.statuses }

  it 'saves to the database' do
    savedJob = Job.create(valid_attributes)
    foundJob = Job.find(savedJob.id)

    expect(foundJob).to have_attributes(valid_attributes)
  end

  context 'instance attributes' do
    let(:job) { jobs(:job_1) }

    it 'has a name' do
      agree(job, :name).will eq('job 1')
    end

    it 'has a status' do
      agree(job, :status).will eq('passed')
    end
  end

  context 'instance methods' do
    let(:job) { jobs(:job_1) }

    describe '.save' do
      it 'returns true on success' do
        fulfill 'job.save -> ?'
        expect(job.save).to eq(true)
      end
    end

    describe '.update' do
      it 'returns true on success' do
        fulfill 'job.update -> ?'
        expect(job.update(valid_attributes)).to eq(true)
      end
    end
  end

  context 'class methods' do
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

    describe '.find' do
      it 'finds a Job by id' do
        agree(Job, :find, '1').will be_a(Job)
      end
    end

    describe '.statuses' do
      it 'provides the list of Job statuses' do
        agree(Job, :statuses).will eq(statuses)
      end
    end
  end

  context 'events' do
    describe '.update' do

      it { fulfill 'Jobs are enqueued to to a JobUpdateBroadcastJob on update' }

      # Copied from rspec/rspec-rails master.
      # Will be available through the rspec-rails dependency when we can upgrade rspec-rails.
      require 'support/active_job'

      before do
        ActiveJob::Base.queue_adapter = :test
      end

      it 'creates a Job to broadcast the update' do
        @updatedJob
        expect {
          @updatedJob = jobs(:job_1).update(valid_attributes)
        }.to have_enqueued_job(JobUpdateBroadcastJob)
                 .with(@updatedJob)
      end
    end
  end
end
