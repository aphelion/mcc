class BuildsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:hook]

  def index
    @builds = model.all
  end

  def new
    @build = model.new
    @statuses = model.statuses.keys
  end

  def create
    @build = model.new(build_params)
    redirect_to @build.save ? builds_path : new_build_path
  end

  def edit
    @build = model.find(params[:id])
    @statuses = model.statuses.keys
  end

  def update
    build = model.find(params[:id])
    redirect_to build.update(build_params) ? builds_path : new_build_path
  end

  def show
    @build = model.find(params[:id])
  end

  def destroy
    build = model.find(params[:id])
    build.destroy
    redirect_to builds_path
  end

  def hook
    case params[:service]
      when 'circle'
        build = model.find(params[:id])
        case params[:payload][:status]
          when 'success'
            build.update(status: :passed)
          when 'failed'
            build.update(status: :failed)
        end
        head :ok
      else
        head :bad_request
    end
  end

  def model
    Build
  end

  private
    def build_params
      params.require(:build).permit(:name, :status)
    end
end
