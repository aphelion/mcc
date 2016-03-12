describe 'channels/builds.coffee' do
  it 'syncs Builds with events from BuildChannel' do
    fulfill 'data-build-table is kept up-to-date'
    contract 'Build creations are streamed to BuildsChannel'

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
