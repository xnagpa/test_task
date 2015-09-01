class Skill < ActiveRecord::Base
  has_many :vacancy_skills
  has_many :vacancies, through: :vacancy_skills, dependent: :destroy

  has_many :worker_skills
  has_many :workers, through: :worker_skills, dependent: :destroy


  validates :skill, presence: true, uniqueness: true


end
