class Api::V1::TasksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_task, only: [:show, :update, :destroy]

  def index
    tasks = Task.all.order(created_at: :desc)
    length = tasks.length
    render json: { status: 'success', message: 'loaded tasks', data: tasks, length: length }
  end

  def show
    render json: { status: 'success', message: 'loaded the task', data: @task }
  end

  def create
    task = Task.new(task_params)
    if task.save
      render json: { status: 'success', data: task }
    else
      render json: { status: 'error', data: task.errors }
    end    
  end

  def update
    if @task.toggle!(:is_done)
      render json: { status: 'success', message: 'update the task', data: @task }
    else
      render json: { status: 'error', message: 'not updated', data: @task.errors }
    end
  end

  def destroy
    @task.destroy
    render json: { status: 'success', message: 'deleted the task', data: @task }
  end

  private

  def task_params
    params.require(:task).permit(:content, :is_done, :week, :notification_time, :user_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
