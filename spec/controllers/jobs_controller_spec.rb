describe JobsController do

  let(:valid_attributes) do
    {name: 'a job'}
  end

  let(:extra_attributes) do
    valid_attributes.merge({danger: 'hackers afoot'})
  end

  context 'object seams' do
    it 'provides the model via #model' do
      fulfill 'JobsController.model -> Job'
      expect(controller.model).to eq(Job)
    end
  end

  context 'actions' do
    let(:model) { double(:Job) }
    let(:jobs) { double(:jobs) }
    let(:job) { double(:job) }

    before do
      contract 'JobsController.model -> Job'
      expect(controller).to receive(:model).and_return(model)
    end

    describe 'GET index' do
      before do
        stipulate(model).must receive(:all).and_return(jobs)
        get :index
      end

      it 'renders its template' do
        fulfill 'jobs#index render template'
        expect(response).to render_template('jobs/index')
      end

      it 'assigns all jobs as @jobs' do
        fulfill 'jobs#index assign @jobs'
        expect(assigns(:jobs)).to be(jobs)
      end
    end

    describe 'GET new' do
      before do
        stipulate(model).must receive(:new).and_return(job)
        get :new
      end

      it 'renders its template' do
        fulfill 'jobs#new render template'
        expect(response).to render_template('jobs/new')
      end

      it 'assigns a new job as @job' do
        fulfill 'jobs#new assign @job'
        expect(assigns(:job)).to be(job)
      end
    end

    describe 'POST create' do
      context 'with valid attributes' do
        let(:job) { Job.new(valid_attributes) }

        it 'creates the Job, saves the Job, and redirects to the Job' do
          stipulate(model).must receive(:new).with(valid_attributes).and_return(job)
          contract('job.save -> ?')
          expect(job).to receive(:save).and_return(true)

          contract('POST -> jobs#create')
          post :create, params: {job: valid_attributes}

          expect(response).to redirect_to(job)
        end
      end

      context 'with extra attributes' do
        let(:job) { Job.new(valid_attributes) }

        it 'filters the extra attributes, creates the Job, and redirects to the Job' do
          stipulate(model).must receive(:new).with(valid_attributes).and_return(job)
          contract('job.save -> ?')
          expect(job).to receive(:save).and_return(true)

          contract('POST -> jobs#create')
          post :create, params: {job: extra_attributes}

          expect(response).to redirect_to(job)
        end
      end

      context 'with invalid attributes' do
        it 'creates the Job, tries to save the Job, and redirects the Job to the new Job page' do
          stipulate(model).must receive(:new).with(valid_attributes).and_return(job)
          contract('job.save -> ?')
          expect(job).to receive(:save).and_return(false)

          contract('POST -> jobs#create')
          post :create, params: {job: extra_attributes}

          expect(response).to redirect_to(new_job_url)
          expect(assigns(:job)).to eq(job)
        end
      end
    end

    describe 'GET show' do
      before do
        stipulate(model).must receive(:find).with('1').and_return(job)
        get :show, params: {id: 1}
      end

      it 'renders its template' do
        fulfill 'jobs#show render template'
        expect(response).to render_template('jobs/show')
      end

      context 'when Job exists' do
        it 'assigns the found Job as @job' do
          fulfill 'jobs#show assign @job'
          expect(assigns(:job)).to eq(job)
        end
      end
    end
  end
end
