class TasksController < ApplicationController
  before_action :set_user, only: [:index, :show, :create, :edit, :updat, :destroy]
  before_action :logged_in_user, only: [:index, :show, :create, :update, :edit, :destroy]
  before_action :correct_user, only: [:index, :show, :create, :update, :edit, :destroy]

  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new(@current_user)
 
  end
  
  def create
    @task = Task.new(task_params,@current_user)
    if @task.save
      flash[:success] = '新規登録に成功しました。'
      redirect_to user_tasks_url @user
    else
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.save
      flash[:success] = 'タスク編集に成功しました。'
      redirect_to @task
    else
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.user = current_user
    @task.destroy
    redirect_to user_tasks_url
  end
  
  private
  
    def task_params
      params.require(:task).permit(:task_name, :note)
    end
    
    def set_user
      @user = User.find(params[:user_id])
    end



    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end
    
end