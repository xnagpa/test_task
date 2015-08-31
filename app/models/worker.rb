class Worker < ActiveRecord::Base
  has_many :worker_skills
  has_many :skills, through: :worker_skills

  accepts_nested_attributes_for :skills, reject_if: :all_blank

  validates :name, presence: true, format: { with: /\w* \w* \w*/,
    message: "Use three words for name" }
  validates :contacts, presence: true, format: { with: /(\w+@.\w+.\w+)|(\+7\d{3}-\d{3}-\d{2}-\d{2})/,
    message: "Use correct format of email or phone (+7XXX-XXX-XX-XX)" }
  validates :salary, presence: true
  validates :status, presence: true

  def list_of_skills
    
  end

end
