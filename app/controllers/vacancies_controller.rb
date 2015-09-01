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
  end

  def edit
    @skills = @vacancy.get_skills_list
    @skill = Skill.new
  end

  private

  def find_vacancy
    @vacancy = Vacancy.find(params[:id])
  end

  def vacancy_params
      byebug
      params.require(:vacancy).permit(:title, :contacts, :till, :salary,  skill_attributes: [:skill_id])
  end
end
