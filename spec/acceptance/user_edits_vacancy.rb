require_relative 'acceptance_helper'
feature 'User edits vacancy', '
   In order to add new info or correct old
   As user
   I want to be able to correct  vacancy data or add new skills
' do
given(:vacancy){FactoryGirl.create(:vacancy, title: "Programmer")}

scenario "User edits vacancy data" do
  visit vacancy_path(vacancy)
  expect(page).to have_content("Edit your vacancy")
  fill_in 'Title', with: 'Programmer needed'
  click_on 'Save'

  visit vacancies_path
  expect(page).to have_content("Programmer needed")

end

scenario "User edits vacancy data" do
  visit vacancy_path(vacancy)
  expect(page).to have_content("Edit your vacancy")

end
end
