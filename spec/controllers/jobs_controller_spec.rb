require 'support/job_attributes'

describe JobsController do
  let(:valid_attributes) { JobAttributes.valid_attributes }
  let(:updated_valid_attributes) { JobAttributes.updated_valid_attributes }
  let(:invalid_attributes) { JobAttributes.invalid_attributes }
  let(:updated_invalid_attributes) { JobAttributes.updated_invalid_attributes }
  let(:extra_attributes) { JobAttributes.extra_attributes }
  let(:statuses) { JobAttributes.statuses }

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
      allow(controller).to receive(:model).and_return(model)
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
        stipulate(model).must receive(:statuses).and_return(statuses)
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

      it 'assigns statuses as @statuses' do
        fulfill 'jobs#new assign @statuses'
        expect(assigns(:statuses)).to eq(statuses.keys)
      end
    end

    describe 'POST create' do
      context 'with valid attributes' do
        let(:job) { Job.new(valid_attributes) }

        it 'creates a Job, saves the Job, and redirects to the Job' do
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

        it 'filters the extra attributes, creates a Job, saves the Job, and redirects to the Job' do
          stipulate(model).must receive(:new).with(valid_attributes).and_return(job)
          contract('job.save -> ?')
          expect(job).to receive(:save).and_return(true)

          contract('POST -> jobs#create')
          post :create, params: {job: extra_attributes}

          expect(response).to redirect_to(job)
        end
      end

      context 'with invalid attributes' do
        it 'creates a Job, tries to save the Job, and redirects the Job to the new Job page' do
          stipulate(model).must receive(:new).with(valid_attributes).and_return(job)
          contract('job.save -> ?')
          expect(job).to receive(:save).and_return(false)

          contract('POST -> jobs#create')
          post :create, params: {job: extra_attributes}

          expect(response).to redirect_to(new_job_path)
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

    describe 'GET edit' do
      before do
        stipulate(model).must receive(:find).with('1').and_return(job)
        stipulate(model).must receive(:statuses).and_return(statuses)
        get :edit, params: {id: 1}
      end

      it 'renders its template' do
        fulfill 'jobs#edit render template'
        expect(response).to render_template('jobs/edit')
      end

      it 'assigns statuses as @statuses' do
        fulfill 'jobs#edit assign @statuses'
        expect(assigns(:statuses)).to eq(statuses.keys)
      end

      context 'when Job exists' do
        it 'assigns the found Job as @job' do
          fulfill 'jobs#edit assign @job'
          expect(assigns(:job)).to eq(job)
        end
      end
    end

    describe 'PUT update' do
      let(:job) { Job.create(valid_attributes) }

      context 'with valid updated attributes' do
        it 'updates the Job, and redirects to the Job' do
          stipulate(model).must receive(:find).with('1').and_return(job)
          contract 'job.update -> ?'
          expect(job).to receive(:update).with(updated_valid_attributes).and_return(true)

          contract 'POST -> jobs#create'
          put :update, params: {id: '1', job: updated_valid_attributes}

          expect(response).to redirect_to(job)
        end
      end

      context 'with invalid updated attributes' do
        it 'updates the Job, and redirects to the Job' do
          stipulate(model).must receive(:find).with('1').and_return(job)
          contract 'job.update -> ?'
          expect(job).to receive(:update).with(updated_invalid_attributes).and_return(false)

          contract 'POST -> jobs#create'
          put :update, params: {id: '1', job: updated_invalid_attributes}

          expect(response).to redirect_to(new_job_path)
        end
      end
    end
  end
end
