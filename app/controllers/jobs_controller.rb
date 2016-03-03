class JobsController < ApplicationController

  def index
    @jobs = model.all
  end

  def model
    Job
  end
end
