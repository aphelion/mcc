describe JobDestroyBroadcastJob do
  let(:server) { double(:server) }

  describe '.perform' do

    before do
      allow(ActionCable).to receive(:server).and_return(server)
    end

    it { fulfill 'Job destroys are broadcast to job_#' }
    it { fulfills 'Job destroys are broadcast by id to JobDisplayChannel' }
    it { contract 'Job ids are enqueued to to a JobDestroyBroadcastJob on destroy' }

    it 'broadcasts the Job as a rendered job display' do
      contract 'jobs/_display renders job'
      expect(server).to receive(:broadcast)
                            .with('job_display_1', event: 'destroy')
      expect(server).to receive(:broadcast)
                            .with('job_1', event: 'destroy')

      subject.perform(1)
    end
  end
end
