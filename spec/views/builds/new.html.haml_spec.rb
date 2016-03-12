describe 'builds/new.html.haml' do
  let(:build) { Build.new }
  let(:statuses) { ['passed', 'failed'] }

  before do
    assign_contract('builds#new', :build, build)
    assign_contract('builds#new', :statuses, statuses)
    render_contract('builds#new')
  end

  it { contract 'builds/_form renders build form' }

  it 'renders a form for the Build' do
    expect(view).to have_rendered(partial: 'form', locals: {build: build, statuses: statuses, cancel_path: builds_path})
  end
end
