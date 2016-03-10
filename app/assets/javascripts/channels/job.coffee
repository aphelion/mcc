@App ||= {}

class App.Job
  constructor: (element) ->
    @jobElement = $(element)
    Job.fitText(@jobElement)

  @fitText: (jobElement) =>
    jobElement.find('.job-title').fitText(0.4, {maxFontSize: '192pt'})

  replace: (element) =>
    jobUpdate = $(element)
    @jobElement.replaceWith(jobUpdate)
    @jobElement = jobUpdate
    Job.fitText(@jobElement)
    @jobElement.hide().fadeIn()

  destroy: (subscription, jobElement) =>
    App.cable.subscriptions.remove(subscription)
    jobElement.fadeOut ->
      jobElement.remove()

  subscribe: =>
    @subscription = App.cable.subscriptions.create {channel: 'JobChannel', job: @jobElement.data('job')},
      connected: =>

      disconnected: =>

      received: (data) =>
        switch data['event']
          when 'update'
            @replace(data['html']['job'])
          when 'destroy'
            @destroy(@subscription, @jobElement)

    $(document).one 'turbolinks:visit', =>
      App.cable.subscriptions.remove(@subscription)


# data-job
$(document).on 'turbolinks:load', ->
  $('[data-job]').each (index, element) ->
    job = new App.Job(element)
    job.subscribe()

#class App.JobTable

# data-job-table
$(document).on 'turbolinks:load', ->
  $('[data-job-table]').each (index, element) ->
    jobTableBody = $(element).find('tbody')

    subscription = App.cable.subscriptions.create {channel: 'JobsChannel'},
      connected: ->

      disconnected: ->

      received: (data) ->
        switch data['event']
          when 'create'
            jobTableRow = $(data['html']['job_table_row'])
            registerJobTableRow(jobTableRow)
            jobTableRow.children('td, th').wrapInner('<div/>').children().hide()
            jobTableBody.append(jobTableRow)
            $.bootstrapSortable(true)
            jobTableRow.children('td, th').children().slideDown()

# data-job-table-row
$(document).on 'turbolinks:load', ->
  $('[data-job-table-row]').each (index, element) ->
    jobTableRow = $(element)
    registerJobTableRow(jobTableRow)

registerJobTableRow = (jobTableRow) ->
  jobId = jobTableRow.data('job-table-row')

  subscription = App.cable.subscriptions.create {channel: 'JobChannel', job: jobId},
    connected: ->

    disconnected: ->

    received: (data) ->
      switch data['event']
        when 'update'
          jobTableRowUpdate = $(data['html']['job_table_row'])

          jobTableRow.fadeOut ->
            jobTableRow.replaceWith ->
              jobTableRow = jobTableRowUpdate
              jobTableRowUpdate.hide().fadeIn()
        when 'destroy'
          App.cable.subscriptions.remove(subscription)
          jobTableRow.fadeTo 400, 0, ->
            jobTableRow.children('td, th').animate(padding: 0).wrapInner('<div/>').children().slideUp ->
              jobTableRow.remove()

  $(document).one 'turbolinks:visit', ->
    App.cable.subscriptions.remove(subscription)
