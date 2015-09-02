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

  def search_workers
    workers = []
    Worker.find_each do |work|
      workers << work unless (skills & work.skills).empty?
      
    end
    workers
  end

end
