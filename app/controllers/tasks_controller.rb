class TasksController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false

  def index
    @incomplete_tasks = Task.where(complete: false)
    @complete_tasks = Task.where(complete: true)
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.create!(set_params)

    respond_to do |f|
      f.html { redirect_to tasks_url }
      f.js
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes!(set_params)

    respond_to do |f|
      f.html { redirect_to tasks_url }
      f.js
    end
  end

  def destroy
    @task = Task.destroy(params[:id])

    respond_to do |f|
      f.html { redirect_to tasks_url }
      f.js
    end
  end

  private

  def set_params
    params.require(:task).permit(:name, :complete)
  end
end
