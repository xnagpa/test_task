require_relative 'acceptance_helper'
feature 'User search for vacancies and workers', '
   In order to find what I want
   As user
   I want to be able to search
' do

given!(:vacancy_programmer){FactoryGirl.create(:vacancy)}
given!(:worker){FactoryGirl.create(:worker)}
given!(:skill){FactoryGirl.create(:mighty_skill)}
given!(:another_skill){FactoryGirl.create(:mighty_skill)}

scenario "Search finds worker with vacancy skills" do
  vacancy_programmer.skills<<skill
  worker.skills<<skill

  visit vacancy_path(vacancy_programmer)
  expect(page).to have_content("Search workers")

  click_on 'Search workers'

  expect(page).to have_content(worker.name)

end

scenario "Search finds worker with vacancy skills and many other skills" do
  vacancy_programmer.skills<<skill
  worker.skills<<skill

  visit vacancy_path(vacancy_programmer)
  expect(page).to have_content("Search workers")

  click_on 'Search workers'

  expect(page).to have_content(worker.name)

end

scenario "Search doesnt find worker without vacancy skills" do
  vacancy_programmer.skills<<skill
  worker.skills<<skill
  worker.skills<<another_skill

  visit vacancy_path(vacancy_programmer)
  expect(page).to have_content("Search workers")

  click_on 'Search workers'

  expect(page).to have_content(worker.name)

end



end
