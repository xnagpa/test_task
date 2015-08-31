require 'rails_helper'

RSpec.describe WorkersController, type: :controller do
 let(:worker){FactoryGirl.create(:worker)}


  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "shows the worker" do
      get :show, id: worker.id
      expect(response).to have_http_status(:success)
    end

  end

  describe "GET #create" do
    it "changes workers count" do
      expect{post :create, worker: FactoryGirl.attributes_for(:worker)}.to change(Worker,:count).by(1)
    end
  end



end
