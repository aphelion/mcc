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
        it 'creates the Job and redirects to the Job index' do
          stipulate(model).must receive(:create).with(valid_attributes).and_return(job)

          contract('POST -> jobs#create')
          post :create, params: {job: valid_attributes}

          expect(response).to redirect_to(jobs_url)
        end
      end

      context 'with extra attributes' do
        it 'filters the extra attributes, creates the Job and redirects to the Job index' do
          stipulate(model).must receive(:create).with(valid_attributes).and_return(job)

          contract('POST -> jobs#create')
          post :create, params: {job: extra_attributes}

          expect(response).to redirect_to(jobs_url)
        end
      end
    end
  end
end
