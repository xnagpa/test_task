class Worker < ActiveRecord::Base
  has_many :worker_skills
  has_many :skills, through: :worker_skills, dependent: :destroy

  accepts_nested_attributes_for :skills, reject_if: :all_blank

  validates :name, presence: true, format: { with: /\w* \w* \w*/,
    message: "Use three words for name" }
  validates :contacts, presence: true, format: { with: /(\w+@.\w+.\w+)|(\+7\d{3}-\d{3}-\d{2}-\d{2})/,
    message: "Use correct format of email or phone (+7XXX-XXX-XX-XX)" }
  validates :salary, presence: true
  validates :status, presence: true

  def get_skills_list
    skills_list = []
    skills.each do |s|
      skills_list << s.skill
    end
    skills_list.join(',')
  end

  def actualize_skills(list)
    #First, if skill was deleted, we need to delete in from DB
    #Second, if skill was added, and it doesn't present in DB we should add it to DB

    current_list_of_skills = get_skills_list.split(",")

    new_or_deleted_skills = (current_list_of_skills | list) - (current_list_of_skills & list)

    new_or_deleted_skills.each do |skill|

      temp_skill = Skill.where(skill: skill).first
      if temp_skill.nil?

        skills << Skill.create(skill: skill)
      else
        #Get rid of deleted skills

        skills.delete(temp_skill)
      end
    end
  end

end
