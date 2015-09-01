require 'rails_helper'

RSpec.describe WorkersController, type: :controller do
 let(:worker){FactoryGirl.create(:worker)}

 describe 'GET #new' do
   let!(:entity) { worker.class.to_s.downcase }
   it_behaves_like 'New entity creator'
 end

 describe 'PATCH #update' do
   let!(:entity_to_update) { FactoryGirl.create(:worker) }

   it_behaves_like 'Entity updater'

   def do_update_request
     patch :update, id: entity_to_update.id,  worker: FactoryGirl.attributes_for(:worker)
   end

   def do_change_content_request
     patch :update, id: entity_to_update.id, worker: { name: 'John' }
   end
 end

 describe "GET #create" do
   it "changes workers count" do
     expect{post :create, worker: FactoryGirl.attributes_for(:worker)}.to change(Worker,:count).by(1)
   end
 end

  describe "GET #index" do
    let(:workers){FactoryGirl.create_list(:worker,2)}
    before{ get :index }
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "fills array" do
        expect(assigns(:workers)).to match_array(workers)
    end
  end

  describe "GET #show" do
    it "shows the worker" do
      get :show, id: worker.id
      expect(response).to have_http_status(:success)
    end

    it 'fills worker' do
      get :show, id: worker.id
      expect(assigns(:worker)).to eq(worker)
    end

  end


end
