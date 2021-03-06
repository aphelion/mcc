describe 'builds/table/_header.html.haml' do
  before do
    fulfill 'builds/table/_header renders'
    render partial: 'builds/table/header'
  end

  describe 'structure' do
    it 'renders thead' do
      assert_select 'thead'
    end

    it 'renders a Build name column header' do
      assert_select 'thead tr th:nth-child(1)', {text: 'name'}
    end

    it 'renders a Build status column header' do
      assert_select 'thead tr th:nth-child(2)', {text: 'status'}
    end

    it 'renders a Build actions column header' do
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

  describe 'responsive layout' do
    it 'displays a single column on small screens' do
      assert_select 'thead tr th:nth-child(1).hidden-xs-down'
      assert_select 'thead tr th:nth-child(2).hidden-xs-down'
      assert_select 'thead tr th:nth-child(3).hidden-xs-down'
      assert_select 'thead tr th:nth-child(4).hidden-sm-up', {text: 'builds'}
    end
  end
end
