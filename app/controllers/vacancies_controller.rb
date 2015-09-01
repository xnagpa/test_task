class VacanciesController < ApplicationController
  respond_to :html
  before_action :find_vacancy, only: [:show, :edit, :update]
  def new
    @vacancy = Vacancy.new
  end

  def index
    @vacancies = Vacancy.all
  end

  def show
    respond_with(@vacancy)
  end

  def create
    @vacancy = Vacancy.create(vacancy_params)
    respond_with(@vacancy)
  end

  def update    
    @vacancy.update(vacancy_params)
    redirect_to @vacancy
  end

  def edit
    @skills = @vacancy.get_skills_list
    @skill = Skill.new
  end

  def search
    @vacancy = Vacancy.find(params[:vacancy_id])
    @workers = @vacancy.search_workers

  end

  private

  def find_vacancy
    @vacancy = Vacancy.find(params[:id])
  end

  def vacancy_params

      params.require(:vacancy).permit(:title, :contacts, :till, :salary)
  end
end
