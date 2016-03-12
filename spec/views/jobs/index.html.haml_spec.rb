describe 'builds/index.html.haml' do
  let(:builds) { all_fixtures(:builds) }

  before do
    assign_contract('builds#index', :builds, builds)
    render_contract('builds#index')
  end

  it 'renders all Builds in a table' do
    contract 'builds/_table renders builds'
    expect(view).to have_rendered(partial: 'builds/_table', locals: {builds: builds})
  end

  it 'links to the new Build page' do
    assert_select 'a', 'New Build', href: new_build_path
  end
end
