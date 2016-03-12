describe 'channels/build.coffee' do
  it 'syncs Builds with events from BuildChannel' do
    fulfill 'data-build is kept up-to-date'
    fulfill 'data-build-table-row is kept up-to-date'
    contract 'Build updates are streamed to BuildChannel(build: id)'
    contract 'Build destroys are streamed to BuildChannel(build: id)'

    #             ______________
    #       ,===:'.,            `-._
    #            `:.`---.__         `-._
    #              `:.     `--.         `.
    #                \.        `.         `.
    #        (,,(,    \.         `.   ____,-`.,
    #     (,'     `/   \.   ,--.___`.'
    # ,  ,'  ,--.  `,   \.;'         `
    #  `{D, {    \  :    \;
    #    V,,'    /  /    //
    #    j;;    /  ,' ,-//.    ,---.      ,
    #    \;'   /  ,' /  _  \  /  _  \   ,'/
    #          \   `'  / \  `'  / \  `.' /
    #           `.___,'   `.__,'   `.__,'

  end
end
