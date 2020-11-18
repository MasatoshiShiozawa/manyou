class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :login_require
  PER = 10

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = current_user.tasks&.page(params[:page]).per(PER)
    @tasks = @tasks.order(created_at: :desc)

    if params[:sort_expired]
      @tasks = current_user.tasks&.page(params[:page]).per(PER)
      @tasks = @tasks.order(created_at: :desc)
    end

    if params[:sort_priority_high]
      @tasks = current_user.tasks&.page(params[:page]).per(PER)
      @tasks = @tasks.order(priority: :desc)
    end

    if params[:task].present?
      @tasks = current_user.tasks
      if params[:task][:title].present? && params[:task][:status].present?
        @tasks = @tasks.where('title LIKE ?', "%#{params[:task][:title]}%")
        @tasks = @tasks.where(status: params[:task][:status])

      elsif params[:task][:title].present?
        @tasks = @tasks.where('title LIKE ?', "%#{params[:task][:title]}%")

      elsif params[:task][:status].present?
        @tasks = @tasks.where(status: params[:task][:status])

      elsif params[:task][:label_id].present?
        @tasklabel = Tasklabel.where(label_id: params[:task][:label_id]).pluck(:task_id)
        @tasks = @tasks.where(id: @tasklabel)
      end
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: "作成しました！"
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end
    # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority, { label_ids: [] })
  end

  def login_require
    redirect_to new_session_path unless current_user
  end
end
