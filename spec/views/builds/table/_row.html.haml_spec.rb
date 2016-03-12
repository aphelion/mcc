describe 'builds/table/_row.html.haml' do
  fixtures(:builds)

  def do_render(build)
    fulfill 'builds/table/_row renders build'
    render partial: 'builds/table/row', locals: {build: build}
  end

  context 'any Build' do
    let(:build) { builds('build_1') }

    before do
      do_render(build)
    end

    describe 'Build text' do
      it 'renders a table row' do
        assert_select 'tr'
      end

      it 'shows the Build name' do
        contract 'build.name -> ""'
        assert_select 'tr td:nth-child(1)', {text: build.name}
      end

      it 'shows the Build status' do
        contract 'build.status -> ""'
        assert_select 'tr td:nth-child(2)', {text: build.status.humanize(capitalize: false)}
      end
    end

    describe 'Build actions' do
      it 'renders a link to the Build edit page' do
        assert_select 'tr td:nth-child(3) a', 'Edit', href: edit_build_path(build)
      end

      it 'renders a link to the Build show page' do
        assert_select 'tr td:nth-child(3) a', 'Launch', href: build_path(build)
      end

      it 'keeps the action buttons together' do
        assert_select 'tr td:nth-child(3).text-nowrap'
      end
    end
  end

  describe 'status colors' do
    context 'status is never run' do
      it 'renders the status in a grey label' do
        do_render(builds('never_run'))
        assert_select 'tr td .label-default'
      end
    end

    context 'status is passed' do
      it 'renders the status in a green label' do
        do_render(builds('passed'))
        assert_select 'tr td .label-success'
      end
    end

    context 'status is failed' do
      it 'renders the status in a red label' do
        do_render(builds('failed'))
        assert_select 'tr td .label-danger'
      end
    end
  end


  describe 'responsive layout' do
    let(:build) { builds('build_1') }

    before do
      do_render(build)
    end

    it 'displays a single column on small screens' do
      assert_select 'tr td:nth-child(1).hidden-xs-down'
      assert_select 'tr td:nth-child(2).hidden-xs-down'
      assert_select 'tr td:nth-child(3).hidden-xs-down'
      assert_select 'tr td:nth-child(4).hidden-sm-up'
    end

    describe 'the small screen single column' do
      describe 'Build text' do
        it 'shows the Build name' do
          contract 'build.name -> ""'
          assert_select 'tr td:nth-child(4)' do
            assert_select 'h3', {text: build.name}
          end
        end

        it 'shows the Build status as colored circles' do
          contract 'build.status -> ""'
          assert_select 'tr td:nth-child(4)' do
            assert_select ".build-status-circle.build-status-#{build.status.dasherize}"
          end
        end
      end

      describe 'Build actions' do
        it 'renders a link to the Build edit page' do
          assert_select 'tr td:nth-child(4)' do
            assert_select 'a', 'Edit', href: edit_build_path(build)
          end
        end

        it 'renders a link to the Build show page' do
          assert_select 'tr td:nth-child(4)' do
            assert_select 'a', 'Launch', href: build_path(build)
          end
        end

        it 'keeps the action buttons together' do
          assert_select 'tr td:nth-child(4) .text-nowrap a', 'Edit'
          assert_select 'tr td:nth-child(4) .text-nowrap a', 'Launch'
        end
      end
    end
  end

  describe 'live updating' do
    let(:build) { builds('build_1') }

    it 'refreshes when the Build has updates' do
      contract 'data-build-table-row is kept up-to-date'
      do_render(build)
      assert_select 'tr[data-build-table-row=?]', build.id.to_s
    end
  end
end
