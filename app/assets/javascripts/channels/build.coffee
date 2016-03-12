@App ||= {}

class App.Build
  constructor: (element) ->
    @buildElement = $(element)
    Build.fitText(@buildElement)

  @fitText: (buildElement) =>
    buildElement.find('.build-title').fitText(0.4, {maxFontSize: '192pt'})

  replace: (element) =>
    buildUpdate = $(element)
    @buildElement.replaceWith(buildUpdate)
    @buildElement = buildUpdate
    Build.fitText(@buildElement)
    @buildElement.hide().fadeIn()

  destroy: (subscription, buildElement) =>
    App.cable.subscriptions.remove(subscription)
    buildElement.fadeOut ->
      buildElement.remove()

  subscribe: =>
    @subscription = App.cable.subscriptions.create {channel: 'BuildChannel', build: @buildElement.data('build')},
      connected: =>

      disconnected: =>

      received: (data) =>
        switch data['event']
          when 'update'
            @replace(data['html']['build'])
          when 'destroy'
            @destroy(@subscription, @buildElement)

    $(document).one 'turbolinks:visit', =>
      App.cable.subscriptions.remove(@subscription)


# data-build
$(document).on 'turbolinks:load', ->
  $('[data-build]').each (index, element) ->
    build = new App.Build(element)
    build.subscribe()

#class App.BuildTable

# data-build-table
$(document).on 'turbolinks:load', ->
  $('[data-build-table]').each (index, element) ->
    buildTableBody = $(element).find('tbody')

    subscription = App.cable.subscriptions.create {channel: 'BuildsChannel'},
      connected: ->

      disconnected: ->

      received: (data) ->
        switch data['event']
          when 'create'
            buildTableRow = $(data['html']['build_table_row'])
            registerBuildTableRow(buildTableRow)
            buildTableRow.children('td, th').wrapInner('<div/>').children().hide()
            buildTableBody.append(buildTableRow)
            $.bootstrapSortable(true)
            buildTableRow.children('td, th').children().slideDown()

# data-build-table-row
$(document).on 'turbolinks:load', ->
  $('[data-build-table-row]').each (index, element) ->
    buildTableRow = $(element)
    registerBuildTableRow(buildTableRow)

registerBuildTableRow = (buildTableRow) ->
  buildId = buildTableRow.data('build-table-row')

  subscription = App.cable.subscriptions.create {channel: 'BuildChannel', build: buildId},
    connected: ->

    disconnected: ->

    received: (data) ->
      switch data['event']
        when 'update'
          buildTableRowUpdate = $(data['html']['build_table_row'])

          buildTableRow.fadeOut ->
            buildTableRow.replaceWith ->
              buildTableRow = buildTableRowUpdate
              buildTableRowUpdate.hide().fadeIn()
        when 'destroy'
          App.cable.subscriptions.remove(subscription)
          buildTableRow.fadeTo 400, 0, ->
            buildTableRow.children('td, th').animate(padding: 0).wrapInner('<div/>').children().slideUp ->
              buildTableRow.remove()

  $(document).one 'turbolinks:visit', ->
    App.cable.subscriptions.remove(subscription)
