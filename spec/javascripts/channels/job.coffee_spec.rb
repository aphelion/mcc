describe 'channels/job.coffee' do
  it 'syncs Jobs with events from JobChannel' do
    fulfill 'data-job is kept up-to-date'
    fulfill 'data-job-table-row is kept up-to-date'
    contract 'Job updates are streamed to JobChannel(job: id)'
    contract 'Job destroys are streamed to JobChannel(job: id)'

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
