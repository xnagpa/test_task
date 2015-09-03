class Vacancy < ActiveRecord::Base
  include Skillable
  has_many :vacancy_skills
  has_many :skills, through: :vacancy_skills, dependent: :destroy

  accepts_nested_attributes_for :skills, reject_if: :all_blank

  validates :title, presence: true
  validates :contacts, presence: true, format: { with: /(\w+@.\w+.\w+)|(\+7\d{3}-\d{3}-\d{2}-\d{2})/,
    message: "Use correct format of email or phone (+7XXX-XXX-XX-XX)" }
  validates :salary, presence: true
  validates :till, presence: true

  def search_workers_full
    # workers = []
    # Worker.find_each do |work|
    #   workers << work unless (skills & work.skills).empty?
    workers_full =  Worker.where(' not exists( (select vs.skill_id from vacancy_skills vs where vs.vacancy_id=?) except
(select ws.skill_id from worker_skills ws where ws.worker_id = workers.id) )',id)
  end

    def search_workers_partial
        workers_full_and_partial=  Worker.where('workers.id in (select ws.worker_id from worker_skills ws inner join vacancy_skills vs on ws.skill_id=vs.skill_id where vs.vacancy_id=?)',id)
        workers_full = search_workers_full
      
        if workers_full_and_partial == workers_full
          workers_full
        else
          workers_partial = workers_full_and_partial - workers_full
        end
    end
end
