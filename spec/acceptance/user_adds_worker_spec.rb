require_relative 'acceptance_helper'

feature 'Agent adds worker to the worker list', '
   In order to find a better job
   As agent
   I want to be able to add info about worker
' do
given(:worker){FactoryGirl.create(:worker)}
    scenario 'Agent creates new worker', js: true do
      visit workers_path
      click_on "Create new employee"
      expect(page).to have_content('Fill worker data: ')

          fill_in 'Name', with: 'Erast Petrovich Fandorin'
          fill_in 'Contacts', with: 'xnagpa@outlook.com'
          fill_in 'Status', with: 'Active search'
          fill_in 'Salary', with: '100000'
          click_on 'Save'

      expect(page).to have_content('Erast Petrovich Fandorin')
      expect(page).to have_content('xnagpa@outlook.com')
      expect(page).to have_content('Active search')
      expect(page).to have_content('100000')
    end

    scenario 'Agent lists workers' do
      FactoryGirl.create_list(:worker, 3)
      visit workers_path

      expect(page).to have_content('Worker', count: 3)
      expect(current_path).to eq '/workers'
    end

    scenario 'Agent watches a certain worker', js: true do

      visit worker_path(worker)

      expect(page).to have_content(worker.name)
      expect(page).to have_content(worker.contacts)
      expect(page).to have_content(worker.status)
      expect(page).to have_content(worker.salary)
      expect(current_path).to eq "/workers/#{worker.id}"
    end
end
