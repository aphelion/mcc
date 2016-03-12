describe 'builds/_build.html.haml' do
  fixtures(:builds)

  def do_render(build)
    fulfill 'builds/_build renders build'
    render partial: 'builds/build', locals: {build: build}
  end

  describe 'Build text' do
    let(:build) { builds('build_1') }

    it 'renders the Build name' do
      do_render(build)
      expect(rendered).to include(build.name)
    end
  end

  describe 'color' do
    context 'when the build passed' do
      it 'is green' do
        do_render(builds('passed'))
        assert_select '.build-status-passed'
      end
    end

    context 'when the build failed' do
      it 'is red' do
        do_render(builds('failed'))
        assert_select '.build-status-failed'
      end
    end

    context 'when the has never run' do
      it 'is white' do
        do_render(builds('never_run'))
        assert_select '.build-status-never-run'
      end
    end
  end

  describe 'live updating' do
    let(:build) { builds('build_1') }

    it 'refreshes when the Build has updates' do
      contract 'data-build is kept up-to-date'
      do_render(build)
      assert_select '[data-build=?]', build.id.to_s
    end
  end
end
