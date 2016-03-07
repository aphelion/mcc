$(document).on 'turbolinks:load', ->
  $('[data-job-display]').each (index, element) ->
    jobDisplay = $(element)
    jobId = jobDisplay.data('job-display')

    subscription = App.cable.subscriptions.create {channel: 'JobDisplayChannel', job: jobId},
      connected: ->

      disconnected: ->

      received: (data) ->
        jobDisplayUpdate = $(data['html'])
        jobDisplay.replaceWith jobDisplayUpdate
        jobDisplay = jobDisplayUpdate

    $(document).one 'turbolinks:visit', ->
      App.cable.subscriptions.remove(subscription)
