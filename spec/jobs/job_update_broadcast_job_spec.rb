describe JobUpdateBroadcastJob do
  let(:job) { double(:job) }
  let(:html) { double(:html) }

  describe '.perform' do

    it { fulfills 'Job updates are broadcast by id' }
    it { contract 'Jobs are enqueued to to a JobUpdateBroadcastJob on update' }

    it 'broadcasts the Job as a rendered job display' do
      allow(job).to receive(:id).and_return(1)
      contract 'jobs/_display renders job'
      expect(ApplicationController).to receive_message_chain('renderer.render')
                                           .with(partial: 'jobs/display', locals: {job: job})
                                           .and_return(html)
      expect(ActionCable).to receive_message_chain('server.broadcast')
                                 .with('job_display_1', html: html)

      subject.perform(job)
    end
  end
end
