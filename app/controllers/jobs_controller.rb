class JobsController < ApplicationController

  def index
    @jobs = model.all
  end

  def new
    @job = model.new
  end

  def create
    @job = model.new(job_params)
    redirect_to @job.save ? @job : new_job_url
  end

  def show
    @job = model.find(params[:id])
  end

  def model
    Job
  end

  private
    def job_params
      params.require(:job).permit(:name)
    end
end
