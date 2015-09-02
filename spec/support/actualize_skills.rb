shared_examples_for 'Skills actualizer' do
  let(:skill_list){FactoryGirl.create_list(:mighty_skill,3)}
  let(:list_generated_by_user){[skill_list[0].skill,skill_list[1].skill,skill_list[2].skill]}
  let(:list_with_deleted_entries){[skill_list[0].skill,skill_list[2].skill]}
  let(:list_with_duplicate_skill){[skill_list[0].skill]}

  it " gets skills list" do
    entity.skills << skill_list
    expect(entity.get_skills_list).to eq "#{entity.skills[0].skill},#{entity.skills[1].skill},#{entity.skills[2].skill}"
  end

  context "it actualizes skills and" do

     it "adds skills with correct names" do
       entity.actualize_skills(list_generated_by_user)
       skill_list.each_with_index do |s,i|
         expect(entity.skills[i].skill).to eq skill_list[i].skill
       end
     end

     it "adds new skills to entity.skills " do
       expect{entity.actualize_skills(list_generated_by_user)}.to change(entity.skills,:count).by(3)
     end

     it "adds new skills to skills table " do
       expect{entity.actualize_skills(list_generated_by_user)}.to change(Skill,:count).by(3)
     end

     it "doesnt add new skills to skills table if it is already presented " do
       entity.actualize_skills(list_generated_by_user)
       expect{entity.actualize_skills(list_with_duplicate_skill)}.to_not change(Skill,:count)
     end

     it "deletes skills from entity.skills if user deleted them in view " do
       entity.actualize_skills(list_generated_by_user)
       expect{entity.actualize_skills([])}.to change(entity.skills,:count).by(-3)
     end
  end

end
