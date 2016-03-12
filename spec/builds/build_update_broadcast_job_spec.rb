describe BuildUpdateBroadcastJob do
  let(:build) { double(:build) }
  let(:build_html) { double(:build_html) }
  let(:build_table_row_html) { double(:build_table_row_html) }
  let(:renderer) { double(:renderer) }
  let(:server) { double(:server) }

  describe '.perform' do

    before do
      allow(ApplicationController).to receive(:renderer).and_return(renderer)
      allow(ActionCable).to receive(:server).and_return(server)
    end

    it { fulfill 'Build updates are broadcast to build_#' }
    it { contract 'Builds are enqueued to to a BuildUpdateBroadcastJob on update' }

    it { contract 'builds/_build renders build' }
    it { contract 'builds/table/_row renders build' }

    it 'broadcasts the Build update event with html' do
      allow(build).to receive(:id).and_return(1)
      expect(renderer).to receive(:render)
                              .with(partial: 'builds/build', locals: {build: build})
                              .and_return(build_html)
      expect(renderer).to receive(:render)
                              .with(partial: 'builds/table/row', locals: {build: build})
                              .and_return(build_table_row_html)
      expect(server).to receive(:broadcast)
                            .with('build_1', event: 'update', html: {build: build_html, build_table_row: build_table_row_html})

      subject.perform(build)
    end
  end
end
