class BuildCreateBroadcastJob < ApplicationJob
  queue_as :default

  def perform(build)
    ActionCable.server.broadcast 'builds',
                                 event: 'create',
                                 html: {build: render_build(build), build_table_row: render_build_table_row(build)}
  end

  private
  def render_build(build)
    ApplicationController.renderer.render(partial: 'builds/build', locals: {build: build})
  end

  private
  def render_build_table_row(build)
    ApplicationController.renderer.render(partial: 'builds/table/row', locals: {build: build})
  end
end
