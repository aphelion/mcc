class JobsController < ApplicationController

  def index
    @jobs = model.all
  end

  def new
    @job = model.new
  end

  def create
    @job = model.new(job_params)
    redirect_to @job.save ? @job : new_job_path
  end

  def show
    @job = model.find(params[:id])
  end

  def edit
    @job = model.find(params[:id])
  end

  def update
    @job = model.find(params[:id])
    redirect_to @job.update(job_params) ? @job : new_job_path
  end

  def model
    Job
  end

  private
    def job_params
      params.require(:job).permit(:name)
    end
end
