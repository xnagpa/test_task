require_relative 'acceptance_helper'

feature 'Agent adds worker to the worker list', '
   In order to find a better job
   As agent
   I want to be able to add info about worker
' do
  given(:worker) { FactoryGirl.create(:worker) }
  scenario 'Agent creates new worker', js: true do
    visit workers_path
    click_on 'Create new employee'
    expect(page).to have_content('Fill worker data: ')
    # within (".inputs") do
    fill_in 'worker[name]', with: 'Сергей Петрович Брин'
    fill_in 'worker[contacts]', with: 'xnagpa@outlook.com'
    select 'Searching', from: 'worker[status]'
    fill_in 'worker[salary]', with: '1'
    click_on 'Save'
    #  end

    expect(page).to have_content('Сергей Петрович Брин')
    expect(page).to have_content('xnagpa@outlook.com')
    expect(page).to have_content('Searching')
    expect(page).to have_content('$1')
  end

  scenario 'Agent lists workers' do
    FactoryGirl.create_list(:worker, 3)
    visit workers_path

    expect(page).to have_content('Employee', count: 3)
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
