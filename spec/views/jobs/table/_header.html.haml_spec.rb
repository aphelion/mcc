describe 'jobs/table/_header.html.haml' do
  before do
    fulfill 'jobs/table/_header renders'
    render partial: 'jobs/table/header'
  end

  describe 'structure' do
    it 'renders thead' do
      assert_select 'thead'
    end

    it 'renders a Job name column header' do
      assert_select 'thead tr th:nth-child(1)', {text: 'name'}
    end

    it 'renders a Job status column header' do
      assert_select 'thead tr th:nth-child(2)', {text: 'status'}
    end

    it 'renders a Job actions column header' do
      assert_select 'thead tr th:nth-child(3)', {text: 'actions'}
    end
  end

  describe 'sorting' do
    it 'sets the name column as the default sort' do
      assert_select 'thead tr th:nth-child(1)[data-defaultsort="asc"]', {text: 'name'}
    end

    it 'disables sorting on the actions column' do
      assert_select 'thead tr th:nth-child(3)[data-defaultsort="disabled"]', {text: 'actions'}
    end
  end
end
