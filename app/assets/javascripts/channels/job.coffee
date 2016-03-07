$(document).on 'turbolinks:load', ->
  $('[data-job]').each (index, element) ->
    job = $(element)
    jobId = job.data('job')

    subscription = App.cable.subscriptions.create {channel: 'JobChannel', job: jobId},
      connected: ->

      disconnected: ->

      received: (data) ->
        switch data['event']
          when 'update'
            jobUpdate = $(data['html'])

            job.fadeOut ->
              job.replaceWith ->
                job = jobUpdate
                jobUpdate.hide().fadeIn()
          when 'destroy'
            App.cable.subscriptions.remove(subscription)
            job.fadeTo 400, 0, ->
              job.slideUp ->
                job.remove()

    $(document).one 'turbolinks:visit', ->
      App.cable.subscriptions.remove(subscription)
