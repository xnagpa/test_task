class WorkersController < ApplicationController
  respond_to :html
  before_action :find_worker, only: [:show, :edit, :update]
  def new
    @worker = Worker.new
  end

  def index
    @workers = Worker.all
  end

  def show
    respond_with(@worker)
  end

  def create
    @worker = Worker.create(worker_params)
    respond_with(@worker)
  end

  def update
    @worker.update(worker_params)
    redirect_to @worker
  end

  def edit
    @skills = @worker.get_skills_list
    @skill = Skill.new
  end

  def search
    @worker = Worker.find(params[:worker_id])
    @vacancies_partial = @worker.search_vacancies_partial
    @vacancies_full = @worker.search_vacancies_full
  end

  private

  def worker_params
    params.require(:worker).permit(:name, :contacts, :status, :salary, :id)
  end

  def find_worker
    @worker = Worker.find(params[:id])
  end
end
