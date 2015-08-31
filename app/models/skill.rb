class Skill < ActiveRecord::Base
  def self.get_skill_list(skillable)
    skills_list=[]
    skillable.skills.each do |s|
      skills_list << s.skill
    end
    skills_list.join(',')
  end
end
