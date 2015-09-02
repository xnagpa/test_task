require_relative 'acceptance_helper'
feature 'User edits vacancy', '
   In order to add new info or correct old
   As user
   I want to be able to correct  vacancy data or add new skills
' do
given(:vacancy){FactoryGirl.create(:vacancy, title: "Programmer")}
given!(:worker){FactoryGirl.create(:worker)}
given!(:skill){FactoryGirl.create(:mighty_skill)}

scenario "User edits vacancy data" do
  visit edit_vacancy_path(vacancy)
  expect(page).to have_content("Edit vacancy data:")
  fill_in 'vacancy[title]', with: 'Programmer needed'
  within('.formtastic.vacancy') do
    click_on 'Save'
  end

  visit vacancies_path
  expect(page).to have_content("Programmer needed")

end

scenario "User adds new skill", js: true do
  visit edit_vacancy_path(vacancy)
 find(:css, "#skill_skill_tag").set("New awesome skill")

  within('.formtastic.skill') do
    click_on 'Save'
  end
  expect(page).to have_content("New awesome skill")
  expect(page).to have_content("Skills saved")
end

# scenario "User deletes his skill", js: true do
#
#   visit edit_vacancy_path(vacancy)
#   save_and_open_page
#   expect(page).to have_content(skill.skill)
#   crosses = page.all(:css, ".tag a")
#   crosses[0].click
#   expect(page).to_not have_content(skill.skill)
#   within('.formtastic.skill') do
#     click_on 'Save'
#   end
#   expect(page).to have_content("Skills saved")
# end


end
