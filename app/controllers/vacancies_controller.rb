class VacanciesController < ApplicationController
  respond_to :html
  before_action :find_vacancy, only: [:show, :update]
  def new
    @vacancy = Vacancy.new
    @skills = Skill.all
  end

  def index
    @vacancies = Vacancy.all
  end

  def update
    @vacancy.update(vacancy_params)

  end

  def show
    respond_with(@vacancy)
  end

  def create
    @vacancy = Vacancy.create(vacancy_params)
    respond_with(@vacancy)
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
