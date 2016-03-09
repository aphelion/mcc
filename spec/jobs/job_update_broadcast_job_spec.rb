describe JobUpdateBroadcastJob do
  let(:job) { double(:job) }
  let(:job_html) { double(:job_html) }
  let(:job_table_row_html) { double(:job_table_row_html) }
  let(:renderer) { double(:renderer) }
  let(:server) { double(:server) }

  describe '.perform' do

    before do
      allow(ApplicationController).to receive(:renderer).and_return(renderer)
      allow(ActionCable).to receive(:server).and_return(server)
    end

    it { fulfill 'Job updates are broadcast to job_#' }
    it { contract 'Jobs are enqueued to to a JobUpdateBroadcastJob on update' }

    it { contract 'jobs/_job renders job' }
    it { contract 'jobs/table/_row renders job' }

    it 'broadcasts the Job update event with html' do
      allow(job).to receive(:id).and_return(1)
      expect(renderer).to receive(:render)
                              .with(partial: 'jobs/job', locals: {job: job})
                              .and_return(job_html)
      expect(renderer).to receive(:render)
                              .with(partial: 'jobs/table/row', locals: {job: job})
                              .and_return(job_table_row_html)
      expect(server).to receive(:broadcast)
                            .with('job_1', event: 'update', html: {job: job_html, job_table_row: job_table_row_html})

      subject.perform(job)
    end
  end
end
