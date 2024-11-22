class TasksController < ApplicationController
  before_action :load_task, only: %i[show edit update destroy mark_as_completed]

  def index
    @tasks = Tasks::Searcher.call(search_params)

    respond_to do |format|
      format.html
      format.js { render partial: "table", locals: { tasks: @tasks } }
    end
  end

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      flash[:success] = "Task created successfully"
      redirect_to tasks_path
    else
      handle_error(@task)
    end
  end

  def update
    if @task.update(task_params)
      flash[:success] = "Task updated successfully"
      redirect_to tasks_path
    else
      handle_error(@task)
    end
  end

  def destroy
    if @task.destroy
      flash[:success] = "Task deleted successfully"
      redirect_to tasks_path
    else
      handle_error(@task)
    end
  end

  def mark_as_completed
    @task.completed!
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to tasks_path }
    end
  end

  private

  def load_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :status, :category_id)
  end

  def search_params
    params.permit(:keyword, :due_date, :status, :category_id, :date_range).merge(current_user: current_user)
  end
end
