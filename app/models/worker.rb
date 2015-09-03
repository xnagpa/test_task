class Worker < ActiveRecord::Base
  include Skillable

  has_many :worker_skills
  has_many :skills, through: :worker_skills, dependent: :destroy

  accepts_nested_attributes_for :skills, reject_if: :all_blank

  validates :name, presence: true, format: { with: /\w* \w* \w*/,
    message: "Use three words for name" }
  validates :contacts, presence: true, format: { with: /(\w+@.\w+.\w+)|(\+7\d{3}-\d{3}-\d{2}-\d{2})/,
    message: "Use correct format of email or phone (+7XXX-XXX-XX-XX)" }
  validates :salary, presence: true
  validates :status, presence: true

  def search_vacancies_partial
    #not effective
    # vacancies = []
    # Vacancy.find_each do |vac|
    #   vacancies << vac unless (skills & vac.skills).empty?
    # end
    # more effective
    vacancies_full_and_partial= Vacancy.where('vacancies.id in (select vs.vacancy_id from vacancy_skills vs inner join worker_skills ws on ws.skill_id=vs.skill_id where ws.worker_id=?)',id)
    vacancies_full_partial =  vacancies_full_and_partial - search_vacancies_full
  end

  def search_vacancies_full
    vacancies_full = Vacancy.where('not exists( (select vs.skill_id from vacancy_skills vs where vs.vacancy_id=vacancies.id) except
(select ws.skill_id from worker_skills ws where ws.worker_id = ?) )', id)
  end
end
