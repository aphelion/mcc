describe 'builds/show.html.haml' do
  fixtures(:builds)
  let(:build) { builds('build_1') }

  before do
    assign_contract('builds#show', :build, build)
    render_contract('builds#show')
  end

  it 'renders the Build' do
    contract 'builds/_build renders build'
    expect(view).to have_rendered(partial: 'builds/_build', locals: {build: build})
  end
end
