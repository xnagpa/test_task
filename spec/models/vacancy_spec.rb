require 'rails_helper'

RSpec.describe Vacancy, type: :model do
  let!(:vacancy){FactoryGirl.create(:vacancy)}
  let(:worker){FactoryGirl.create(:worker)}
  let!(:skill){FactoryGirl.create(:mighty_skill)}
  let!(:another_skill){FactoryGirl.create(:mighty_skill)}

  it { expect(subject).to validate_presence_of :title}
  it { expect(subject).to validate_presence_of :contacts}
  it { expect(subject).to validate_presence_of :salary }
  it { expect(subject).to validate_presence_of :till }

  it { expect(subject).to allow_value("email@addresse.foo").for(:contacts) }
  it { expect(subject).to allow_value("ema13il@addresse.foo").for(:contacts) }
  it { expect(subject).to_not allow_value("emaaddresse.foo").for(:contacts) }
  it { expect(subject).to allow_value("+7916-888-96-90").for(:contacts) }
  it { expect(subject).to_not allow_value("+791696-90").for(:contacts) }

  let(:entity){vacancy}
  it_behaves_like 'Skills actualizer'


    it "searches for those who have skills" do
      vacancy.skills<<skill
      worker.skills<<skill
      expect(vacancy.search_workers_full[0]).to eq worker
    end

    it "searches for those who have skills partially " do
      vacancy.skills<<skill
      vacancy.skills << another_skill
      worker.skills << skill
      expect(vacancy.search_workers_partial[0]).to eq worker
    end

    it " doesnt search  for those who doesnt have skills" do
      worker.skills<<skill
      vacancy.skills<<another_skill
      expect(vacancy.search_workers_full[0]).to be_nil
    end

    it " doesnt search  for those who doesnt have skills even partially" do
      worker.skills<<skill
      vacancy.skills<<another_skill
      expect(vacancy.search_workers_partial[0]).to be_nil
    end
end
