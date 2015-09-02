FactoryGirl.define do
  sequence :skill do |n|
      "MightySkill#{n}"
  end
factory :mighty_skill, class: Skill do
    skill 
  end

end
