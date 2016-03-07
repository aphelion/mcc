$(document).on 'turbolinks:load', ->
  $('[data-job-display]').each (index, element) ->
    jobDisplay = $(element)
    jobId = jobDisplay.data('job-display')

    subscription = App.cable.subscriptions.create {channel: 'JobDisplayChannel', job: jobId},
      connected: ->

      disconnected: ->

      received: (data) ->
        switch data['event']
          when 'update'
            jobDisplayUpdate = $(data['html'])

            jobDisplay.fadeOut ->
              jobDisplay.replaceWith ->
                jobDisplay = jobDisplayUpdate
                jobDisplayUpdate.hide().fadeIn()
          when 'destroy'
            App.cable.subscriptions.remove(subscription)
            jobDisplay.fadeOut ->
              jobDisplay.remove()

    $(document).one 'turbolinks:visit', ->
      App.cable.subscriptions.remove(subscription)
