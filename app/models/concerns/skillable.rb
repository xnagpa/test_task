module Skillable
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

    new_or_deleted_skills = (current_list_of_skills | list)
    
    skills.delete_all

    new_or_deleted_skills.each do |s|

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
