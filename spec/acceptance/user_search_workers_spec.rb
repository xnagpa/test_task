require_relative 'acceptance_helper'
feature 'User search for vacancies and workers', '
   In order to find what I want
   As user
   I want to be able to search for workers
' do
  given!(:vacancy_programmer) { FactoryGirl.create(:vacancy) }
  given!(:worker) { FactoryGirl.create(:worker) }
  given!(:another_worker) { FactoryGirl.create(:worker) }
  given!(:skill) { FactoryGirl.create(:mighty_skill) }
  given!(:another_skill) { FactoryGirl.create(:mighty_skill) }
  given!(:another_skill2) { FactoryGirl.create(:mighty_skill) }

  scenario 'Search finds vacancy with workers skills' do
    vacancy_programmer.skills << skill
    worker.skills << skill

    visit worker_path(worker)
    expect(page).to have_content('Search vacancies')

    click_on 'Search vacancies'

    expect(page).to have_content(vacancy_programmer.title)
  end

  scenario 'Search finds vacancy with partial workers skills' do
    vacancy_programmer.skills << skill
    vacancy_programmer.skills << another_skill
    worker.skills << skill

    visit worker_path(worker)
    expect(page).to have_content('Search vacancies')

    click_on 'Search vacancies'

    expect(page).to have_content(vacancy_programmer.title)
  end

  scenario 'Search finds vacancy with worker skills and many other skills' do
    worker.skills << skill
    vacancy_programmer.skills << skill
    vacancy_programmer.skills << another_skill
    vacancy_programmer.skills << another_skill2

    visit worker_path(worker)
    expect(page).to have_content('Search vacancies')

    click_on 'Search vacancies'

    expect(page).to have_content(vacancy_programmer.title)
  end

  scenario 'Search doesnt find with skills inappropriate for worker' do
    vacancy_programmer.skills << skill
    worker.skills << another_skill

    visit worker_path(worker)
    expect(page).to have_content('Search vacancies')

    click_on 'Search vacancies'

    expect(page).to_not have_content(vacancy_programmer.title)
  end
end
