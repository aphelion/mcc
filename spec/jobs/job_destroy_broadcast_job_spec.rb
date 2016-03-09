describe JobDestroyBroadcastJob do
  let(:server) { double(:server) }

  describe '.perform' do

    before do
      allow(ActionCable).to receive(:server).and_return(server)
    end

    it { fulfill 'Job destroys are broadcast to job_#' }
    it { contract 'Job ids are enqueued to to a JobDestroyBroadcastJob on destroy' }

    it 'broadcasts the Job destroy event' do
      expect(server).to receive(:broadcast)
                            .with('job_1', event: 'destroy')

      subject.perform(1)
    end
  end
end
