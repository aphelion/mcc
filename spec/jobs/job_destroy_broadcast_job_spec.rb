describe BuildDestroyBroadcastJob do
  let(:server) { double(:server) }

  describe '.perform' do

    before do
      allow(ActionCable).to receive(:server).and_return(server)
    end

    it { fulfill 'Build destroys are broadcast to build_#' }
    it { contract 'Build ids are enqueued to to a BuildDestroyBroadcastJob on destroy' }

    it 'broadcasts the Build destroy event' do
      expect(server).to receive(:broadcast)
                            .with('build_1', event: 'destroy')

      subject.perform(1)
    end
  end
end
