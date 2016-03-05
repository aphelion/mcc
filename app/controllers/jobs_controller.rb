class JobsController < ApplicationController

  def index
    @jobs = model.all
  end

  def new
    @job = model.new
  end

  def create
    model.create(job_params)
    redirect_to jobs_url
  end

  def model
    Job
  end

  private
    def job_params
      params.require(:job).permit(:name)
    end
end
