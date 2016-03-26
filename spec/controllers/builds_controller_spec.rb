require 'support/build_attributes'

describe BuildsController do
  let(:valid_attributes) { BuildAttributes.valid_attributes }
  let(:updated_valid_attributes) { BuildAttributes.updated_valid_attributes }
  let(:invalid_attributes) { BuildAttributes.invalid_attributes }
  let(:updated_invalid_attributes) { BuildAttributes.updated_invalid_attributes }
  let(:extra_attributes) { BuildAttributes.extra_attributes }
  let(:statuses) { BuildAttributes.statuses }

  context 'object seams' do
    it 'provides the model via #model' do
      fulfill 'BuildsController.model -> Build'
      expect(controller.model).to eq(Build)
    end
  end

  context 'actions' do
    let(:model) { double(:Build) }
    let(:builds) { double(:builds) }
    let(:build) { double(:build) }

    before do
      contract 'BuildsController.model -> Build'
      allow(controller).to receive(:model).and_return(model)
    end

    describe 'GET index' do
      before do
        stipulate(model).must receive(:all).and_return(builds)
        get :index
      end

      it 'renders its template' do
        fulfill 'builds#index render template'
        expect(response).to render_template('builds/index')
      end

      it 'assigns all builds as @builds' do
        fulfill 'builds#index assign @builds'
        expect(assigns(:builds)).to be(builds)
      end
    end

    describe 'GET new' do
      before do
        stipulate(model).must receive(:new).and_return(build)
        stipulate(model).must receive(:statuses).and_return(statuses)
        get :new
      end

      it 'renders its template' do
        fulfill 'builds#new render template'
        expect(response).to render_template('builds/new')
      end

      it 'assigns a new build as @build' do
        fulfill 'builds#new assign @build'
        expect(assigns(:build)).to be(build)
      end

      it 'assigns statuses as @statuses' do
        fulfill 'builds#new assign @statuses'
        expect(assigns(:statuses)).to eq(statuses.keys)
      end
    end

    describe 'POST create' do
      context 'with valid attributes' do
        let(:build) { Build.new(valid_attributes) }

        it 'creates a Build, saves the Build, and redirects to the Builds page' do
          stipulate(model).must receive(:new).with(valid_attributes).and_return(build)
          contract('build.save -> ?')
          expect(build).to receive(:save).and_return(true)

          post :create, params: {build: valid_attributes}

          expect(response).to redirect_to(builds_path)
        end
      end

      context 'with extra attributes' do
        let(:build) { Build.new(valid_attributes) }

        it 'filters the extra attributes, creates a Build, saves the Build, and redirects to the Builds page' do
          stipulate(model).must receive(:new).with(valid_attributes).and_return(build)
          contract('build.save -> ?')
          expect(build).to receive(:save).and_return(true)

          post :create, params: {build: extra_attributes}

          expect(response).to redirect_to(builds_path)
        end
      end

      context 'with invalid attributes' do
        it 'creates a Build, tries to save the Build, and redirects the Build to the new Build page' do
          stipulate(model).must receive(:new).with(valid_attributes).and_return(build)
          contract('build.save -> ?')
          expect(build).to receive(:save).and_return(false)

          post :create, params: {build: extra_attributes}

          expect(response).to redirect_to(new_build_path)
          expect(assigns(:build)).to eq(build)
        end
      end
    end

    describe 'GET edit' do
      before do
        stipulate(model).must receive(:find).with('1').and_return(build)
        stipulate(model).must receive(:statuses).and_return(statuses)
        get :edit, params: {id: 1}
      end

      it 'renders its template' do
        fulfill 'builds#edit render template'
        expect(response).to render_template('builds/edit')
      end

      it 'assigns statuses as @statuses' do
        fulfill 'builds#edit assign @statuses'
        expect(assigns(:statuses)).to eq(statuses.keys)
      end

      context 'when Build exists' do
        it 'assigns the found Build as @build' do
          fulfill 'builds#edit assign @build'
          expect(assigns(:build)).to eq(build)
        end
      end
    end

    describe 'PUT update' do
      let(:build) { Build.create(valid_attributes) }

      context 'with valid updated attributes' do
        it 'updates the Build, and redirects to the Builds page' do
          stipulate(model).must receive(:find).with('1').and_return(build)
          contract 'build.update -> ?'
          expect(build).to receive(:update).with(updated_valid_attributes).and_return(true)

          put :update, params: {id: '1', build: updated_valid_attributes}

          expect(response).to redirect_to(builds_path)
        end
      end

      context 'with invalid updated attributes' do
        it 'updates the Build, and redirects the Build to the new Build page' do
          stipulate(model).must receive(:find).with('1').and_return(build)
          contract 'build.update -> ?'
          expect(build).to receive(:update).with(updated_invalid_attributes).and_return(false)

          put :update, params: {id: '1', build: updated_invalid_attributes}

          expect(response).to redirect_to(new_build_path)
        end
      end
    end

    describe 'GET show' do
      before do
        stipulate(model).must receive(:find).with('1').and_return(build)
        get :show, params: {id: 1}
      end

      it 'renders its template' do
        fulfill 'builds#show render template'
        expect(response).to render_template('builds/show')
      end

      context 'when Build exists' do
        it 'assigns the found Build as @build' do
          fulfill 'builds#show assign @build'
          expect(assigns(:build)).to eq(build)
        end
      end
    end

    describe 'DELETE destroy' do

      context 'when Build exists' do
        before do
          stipulate(model).must receive(:find).with('1').and_return(build)
        end

        context 'when delete succeeds' do
          before do
            contract 'build.destroy works'
            expect(build).to receive(:destroy)
          end

          it 'deletes the Build and redirects to the Builds index' do
            fulfill 'delete builds#destroy {"id"=>"1"}'
            delete :destroy, params: {id: 1}

            expect(response).to redirect_to(builds_path)
          end
        end
      end
    end

    describe 'POST hook' do

      context 'when Build exists' do
        before do
          allow(model).to receive(:find).with('1').and_return(build)
          allow(build).to receive(:name).and_return('circle')
          allow(build).to receive(:update)
        end

        def do_post_passed
          fulfill 'post builds#hook {"id"=>"1", "service"=>"circle"}'
          post :hook, params: {id: '1', service: 'circle', payload: {status: 'success'}}
        end

        def do_post_failed
          fulfill 'post builds#hook {"id"=>"1", "service"=>"circle"}'
          post :hook, params: {id: '1', service: 'circle', payload: {status: 'failed'}}
        end

        context 'when provider is circle' do
          it 'responds with HTTP status OK' do
            do_post_passed

            expect(response).to have_http_status(:ok)
          end

          context 'when the build passed' do
            it 'updates the build with passed status' do
              expect(build).to receive(:update).with(status: :passed)

              do_post_passed
            end
          end

          context 'when the build failed' do
            it 'updates the build with failed status' do
              expect(build).to receive(:update).with(status: :failed)

              do_post_failed
            end
          end
        end

        context 'when provider is something unexpected' do
          it 'responds HTTP status Bad Request' do
            fulfill 'post builds#hook {"id"=>"1", "service"=>"circle"}'
            post :hook, params: {id: '1', service: 'hackers'}

            expect(response).to have_http_status(:bad_request)
          end
        end
      end
    end
  end
end
