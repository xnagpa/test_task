require_relative 'acceptance_helper'

feature 'User adds vacancy list', '
   In order to find a better worker
   As user
   I want to be able to add vacancy
' do
  given(:vacancy) { FactoryGirl.create(:vacancy) }
  scenario 'User creates vacancy', js: true do
    visit vacancies_path
    click_on 'Create new vacancy'
    expect(page).to have_content('Fill vacancy data: ')

    fill_in 'vacancy[title]', with: 'Statskiy sovetnik'
    fill_in 'vacancy[contacts]', with: 'tsarskydvor@kremlin.ru'
    fill_in 'vacancy[salary]', with: '2000000'
    select '2015', from: 'vacancy[till(1i)]'
    select 'January', from: 'vacancy[till(2i)]'
    select '27', from: 'vacancy[till(3i)]'

    click_on 'Save'

    expect(page).to have_content('Statskiy sovetnik')
    expect(page).to have_content('tsarskydvor@kremlin.ru')
    expect(page).to have_content('Vacancy is valid till 27:01:15')
    expect(page).to have_content('$2,000,000.00')
  end

  scenario 'User lists vacancies' do
    FactoryGirl.create_list(:vacancy, 3)
    visit vacancies_path

    expect(page).to have_content('Salary', count: 3)
    expect(current_path).to eq '/vacancies'
  end

  scenario 'User watches a certain vacancy', js: true do
    visit vacancy_path(vacancy)
    expect(page).to have_content(vacancy.title)
    expect(page).to have_content(vacancy.contacts)
    expect(page).to have_content(vacancy.till.strftime('%d:%m:%y'))
    expect(page).to have_content(vacancy.salary)
    expect(current_path).to eq "/vacancies/#{vacancy.id}"
  end
end
