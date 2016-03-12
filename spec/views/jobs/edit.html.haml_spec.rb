describe 'builds/edit.html.haml' do
  fixtures(:builds)
  let(:build) { builds(:build_1) }
  let(:statuses) { ['passed', 'failed'] }

  before do
    assign_contract('builds#edit', :build, build)
    assign_contract('builds#edit', :statuses, statuses)
    render_contract('builds#edit')
  end

  it { contract 'builds/_form renders build form' }

  it 'renders a form for the Build' do
    expect(view).to have_rendered(partial: 'form', locals: {build: build, statuses: statuses, cancel_path: builds_path})
  end
end
