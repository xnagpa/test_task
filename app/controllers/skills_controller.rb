class SkillsController < ApplicationController
  before_action :find_skillable, only: [:create]

  def create
    skill_list = skill_params[:skill].split(",")  
    @skillable.actualize_skills(skill_list)
  end

  private

  def skill_params
      params.require(:skill).permit(:skill)
  end

  def find_skillable
      if params[:worker_id]
        @skillable =  Worker.find(params[:worker_id])
      elsif params[:vacancy_id]
        @skillable = Vacancy.find(params[:vacancy_id])
      end
  end
end
