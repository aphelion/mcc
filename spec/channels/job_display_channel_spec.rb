describe 'JobDisplayChannel' do
  it 'broadcasts Job updates to subscribers' do
    fulfill 'Job updates are streamed to JobDisplayChannel(job: id)'
    contract 'Job updates are broadcast by id to JobDisplayChannel'

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
