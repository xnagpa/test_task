require 'rails_helper'

RSpec.describe SkillsController, type: :controller do
  describe "GET #create" do
    let!(:worker) { FactoryGirl.create(:worker) }
    it "changes skills count" do
      expect{post :create, worker_id: worker.id, skill: FactoryGirl.attributes_for(:mighty_skill), format: :js}.to change(Skill,:count).by(1)
    end
  end
end
