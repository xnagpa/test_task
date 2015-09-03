module Skillable
  def get_skills_list
    skills_list = []
    skills.each do |s|
      skills_list << s.skill
    end
    skills_list.join(',')
  end

  def actualize_skills(list)
    # First, if skill was deleted, we need to delete in from DB
    # Second, if skill was added, and it doesn't present in DB we should add it to DB

    skills.delete_all

    list.each do |s|
      temp_skill = Skill.where(skill: s).first
      if temp_skill.nil?
        skills << Skill.create(skill: s)
      else
        skills << temp_skill
      end
      # else
      #   #Get rid of deleted skills
      #
      #   skills.delete(temp_skill)
    end
  end
end
