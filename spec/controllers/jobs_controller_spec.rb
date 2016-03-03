describe JobsController do
  context 'object seams' do
    it 'provides the model via #model' do
      fulfill 'JobsController.model -> Job'
      expect(controller.model).to eq(Job)
    end
  end

  context 'actions' do
    let(:model) { double(:Job) }
    let(:jobs) { double(:jobs) }

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
  end
end
