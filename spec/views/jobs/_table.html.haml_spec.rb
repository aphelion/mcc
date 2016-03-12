require 'support/fixture_helpers'

describe 'builds/_table.html.haml' do
  fixtures(:builds)
  let(:builds) { all_fixtures(:builds) }

  before do
    contract 'builds/table/_header renders'
    contract 'builds/table/_row renders build'
    fulfill 'builds/_table renders builds'
    render partial: 'builds/table', locals: {builds: builds}
  end

  describe 'structure' do
    it 'renders the header in a table' do
      assert_select 'table thead'
      expect(view).to have_rendered(partial: 'builds/table/_header')
    end

    it 'renders the rows in a body in a table' do
      assert_select 'table tbody tr', {count: builds.count}
      expect(view).to have_rendered(partial: 'builds/table/_row', count: builds.count)
    end
  end

  describe 'sorting' do
    it 'configures the table to be sortable' do
      assert_select 'table.sortable'
    end
  end

  describe 'live updating' do
    it 'receives new Builds' do
      contract 'data-build-table is kept up-to-date'
      assert_select 'table[data-build-table]'
    end
  end
end
