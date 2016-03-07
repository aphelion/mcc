$(document).on 'turbolinks:load', ->
  $('[data-job]').each (index, element) ->
    job = $(element)
    jobId = job.data('job')

    subscription = App.cable.subscriptions.create {channel: 'JobChannel', job: jobId},
      connected: ->

      disconnected: ->

      received: (data) ->
        jobUpdate = $(data['html'])

        job.fadeOut ->
          job.replaceWith ->
            jobUpdate.hide().fadeIn()
            job = jobUpdate

    $(document).one 'turbolinks:visit', ->
      App.cable.subscriptions.remove(subscription)
