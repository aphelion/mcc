require 'support/fixture_helpers'

describe 'jobs/_table.html.haml' do
  fixtures(:jobs)
  let(:jobs) { all_fixtures(:jobs) }

  before do
    contract 'jobs/table/_header renders'
    contract 'jobs/table/_row renders job'
    fulfill 'jobs/_table renders jobs'
    render partial: 'jobs/table', locals: {jobs: jobs}
  end

  describe 'structure' do
    it 'renders the header in a table' do
      assert_select 'table thead'
      expect(view).to have_rendered(partial: 'jobs/table/_header')
    end

    it 'renders the rows in a body in a table' do
      assert_select 'table tbody tr', {count: jobs.count}
      expect(view).to have_rendered(partial: 'jobs/table/_row', count: jobs.count)
    end
  end

  describe 'sorting' do
    it 'configures the table to be sortable' do
      assert_select 'table.sortable'
    end
  end

  describe 'live updating' do
    it 'receives new Jobs' do
      contract 'data-job-table is kept up-to-date'
      assert_select 'table[data-job-table]'
    end
  end
end
