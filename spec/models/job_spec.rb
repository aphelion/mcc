require 'support/fixture_helpers'
require 'support/build_attributes'

describe Build do
  fixtures(:builds)
  let(:valid_attributes) { BuildAttributes.valid_attributes }
  let(:statuses) { BuildAttributes.statuses }

  it 'saves to the database' do
    savedBuild = Build.create(valid_attributes)
    foundBuild = Build.find(savedBuild.id)

    expect(foundBuild).to have_attributes(valid_attributes)
  end

  context 'instance attributes' do
    let(:build) { builds(:build_1) }

    it 'has a name' do
      agree(build, :name).will eq('build 1')
    end

    it 'has a status' do
      agree(build, :status).will eq('passed')
    end
  end

  context 'instance methods' do
    let(:build) { builds(:build_1) }

    describe '.save' do
      it 'returns true on success' do
        fulfill 'build.save -> ?'
        expect(build.save).to eq(true)
      end
    end

    describe '.update' do
      it 'returns true on success' do
        fulfill 'build.update -> ?'
        expect(build.update(valid_attributes)).to eq(true)
      end
    end

    describe '.destroy' do
      it 'returns true on success' do
        fulfill 'build.destroy works'
        build.destroy
        expect(build.destroyed?).to eq(true)
      end
    end
  end

  context 'class methods' do
    describe '.all' do
      let(:builds) { all_fixtures(:builds) }

      it 'returns all Builds' do
        agree(Build, :all).will eq(builds)
      end
    end

    describe '.new' do
      context 'with no parameters' do
        it 'returns a new Build' do
          agree(Build, :new).will be_a(Build)
        end
      end

      context 'with a hash' do
        it 'returns a new Build' do
          agree(Build, :new, valid_attributes).will be_a(Build)
        end
      end
    end

    describe '.find' do
      it 'finds a Build by id' do
        agree(Build, :find, '1').will be_a(Build)
      end
    end

    describe '.statuses' do
      it 'provides the list of Build statuses' do
        agree(Build, :statuses).will eq(statuses)
      end
    end
  end

  context 'events' do
    # Copied from rspec/rspec-rails master.
    # Will be available through the rspec-rails dependency when we can upgrade rspec-rails.
    require 'support/active_job'

    before do
      ActiveJob::Base.queue_adapter = :test
    end

    describe '.create' do
      it { fulfill 'Builds are enqueued to to a BuildCreateBroadcastJob on create' }

      it 'creates a Build to broadcaste the create' do
        @createdBuild
        expect {
          @createdBuild = Build.create(valid_attributes)
        }.to have_enqueued_job(BuildCreateBroadcastJob)
                 .with(@createdBuild)
      end
    end

    describe '.update' do
      it { fulfill 'Builds are enqueued to to a BuildUpdateBroadcastJob on update' }

      it 'creates a Build to broadcast the update' do
        @updatedBuild
        expect {
          @updatedBuild = builds(:build_1).update(valid_attributes)
        }.to have_enqueued_job(BuildUpdateBroadcastJob)
                 .with(@updatedBuild)
      end
    end

    describe '.destroy' do
      it { fulfill 'Build ids are enqueued to to a BuildDestroyBroadcastJob on destroy' }

      let(:build) { builds(:build_1) }

      it 'creates a Build to broadcast the destroy' do
        expect {
          build.destroy
        }.to have_enqueued_job(BuildDestroyBroadcastJob)
                 .with(build.id)
      end
    end
  end
end
