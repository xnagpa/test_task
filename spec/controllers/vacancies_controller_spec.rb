require 'rails_helper'

RSpec.describe VacanciesController, type: :controller do
  let(:vacancy) { FactoryGirl.create(:vacancy) }

  describe 'GET #index' do
    let(:vacancies) { FactoryGirl.create_list(:vacancy, 2) }
    before { get :index }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'fills array' do
      expect(assigns(:vacancies)).to match_array(vacancies)
    end
  end

  describe 'GET #show' do
    before { get :show, id: vacancy.id }

    it 'shows the vacancy' do
      expect(response).to have_http_status(:success)
    end

    it 'fills vacancy' do
      get :show, id: vacancy.id
      expect(assigns(:vacancy)).to eq(vacancy)
    end
  end

  describe 'POST #create' do
    it 'changes vacancies count' do
      expect { post :create, vacancy: FactoryGirl.attributes_for(:vacancy) }.to change(Vacancy, :count).by(1)
    end
  end
end
