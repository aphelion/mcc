describe 'builds/_form.html.haml' do
  fixtures(:builds)
  let(:statuses) { ['passed', 'failed'] }

  it { fulfill 'builds/_form renders build form' }

  describe 'basic form composition' do
    let(:build) { builds(:build_1) }
    before do
      render partial: 'builds/form', locals: {build: build, statuses: statuses}
    end

    it 'renders a pre-populated input for name' do
      assert_select 'input#build_name[value=?]', build.name
    end

    it 'renders a pre-selected select for status' do
      assert_select 'select#build_status'
      statuses.each do |status|
        assert_select 'select#build_status option[value=?]', status, {text: status.humanize(capitalize: false)}
      end
      assert_select 'select#build_status option[selected][value=?]', 'passed'
    end

    it 'renders a submit button' do
      assert_select 'input[type=?]', 'submit'
    end
  end

  describe 'cancel button' do
    let(:build) { builds(:build_1) }
    context 'when cancel_path is supplied' do
      it 'renders a cancel button' do
        render partial: 'builds/form', locals: {build: build, statuses: statuses, cancel_path: build_path(build)}
        assert_select 'a', 'Cancel', href: build_path(build)
      end
    end

    context 'when cancel_path is not supplied' do
      it 'does not render a cancel button' do
        render partial: 'builds/form', locals: {build: build, statuses: statuses}
        assert_select 'a', {text: 'Cancel', count: 0}
      end
    end
  end

  context 'when Build is new' do
    let(:build) { Build.new }

    before do
      render partial: 'builds/form', locals: {build: build, statuses: statuses}
    end

    it 'submits POST to builds' do
      assert_select 'form[action=?][method=?]', builds_path, 'post'
    end

    it 'does not render a delete button' do
      assert_select 'a', {text: 'Delete', count: 0}
    end
  end

  context 'when Build already exists' do
    let(:build) { builds(:build_1) }

    before do
      render partial: 'builds/form', locals: {build: build, statuses: statuses}
    end

    it 'submits POST to build' do
      assert_select 'form[action=?][method=?]', build_path(build), 'post'
    end

    it 'renders a delete button' do
      contract 'DELETE /builds/#'
      assert_select 'a', 'Delete', {method: :delete, href: build_path(build)}
    end
  end
end
