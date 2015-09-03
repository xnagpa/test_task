require_relative 'acceptance_helper'
feature 'User edits worker', '
   In order to add new info or correct old
   As user
   I want to be able to correct  worker data or add new skills
' do
  given(:vacancy) { FactoryGirl.create(:vacancy, title: 'Programmer') }
  given!(:worker) { FactoryGirl.create(:worker) }
  given!(:skill) { FactoryGirl.create(:mighty_skill) }

  scenario 'User edits worker data' do
    visit edit_worker_path(worker)
    expect(page).to have_content('Fill worker data:')
    fill_in 'worker[name]', with: 'Изуми Коната Тимотеевна'
    within('.formtastic.worker') do
      click_on 'Save'
    end
    visit worker_path(worker)
    expect(page).to have_content('Изуми Коната Тимотеевна')
  end

  scenario 'User adds new skill', js: true do
    visit edit_vacancy_path(vacancy)
    find(:css, '#skill_skill_tag').set('New awesome skill')

    within('.formtastic.skill') do
      click_on 'Save'
    end
    expect(page).to have_content('New awesome skill')
    expect(page).to have_content('Skills saved')
  end
end
