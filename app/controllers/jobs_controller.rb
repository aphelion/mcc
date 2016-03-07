class JobsController < ApplicationController

  def index
    @jobs = model.all
  end

  def new
    @job = model.new
    @statuses = model.statuses.keys
  end

  def create
    @job = model.new(job_params)
    redirect_to @job.save ? jobs_path : new_job_path
  end

  def edit
    @job = model.find(params[:id])
    @statuses = model.statuses.keys
  end

  def update
    @job = model.find(params[:id])
    redirect_to @job.update(job_params) ? jobs_path : new_job_path
  end

  def display
    @job = model.find(params[:id])
  end

  def model
    Job
  end

  private
    def job_params
      params.require(:job).permit(:name, :status)
    end
end
