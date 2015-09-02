require 'rails_helper'

RSpec.describe Worker, type: :model do
  let!(:vacancy_programmer){FactoryGirl.create(:vacancy)}
  let!(:worker){FactoryGirl.create(:worker)}
  let!(:skill){FactoryGirl.create(:mighty_skill)}


  it { expect(subject).to validate_presence_of :name}
  it { expect(subject).to validate_presence_of :contacts}
  it { expect(subject).to validate_presence_of :salary }
  it { expect(subject).to validate_presence_of :status }

  it { expect(subject).to allow_value("email@addresse.foo").for(:contacts) }
  it { expect(subject).to allow_value("ema13il@addresse.foo").for(:contacts) }
  it { expect(subject).to_not allow_value("emaaddresse.foo").for(:contacts) }
  it { expect(subject).to allow_value("+7916-888-96-90").for(:contacts) }
  it { expect(subject).to_not allow_value("+791696-90").for(:contacts) }



  let(:entity){worker}
  it_behaves_like 'Skills actualizer'

  it "searches for those who have skills" do
    worker.skills<<skill
    vacancy_programmer.skills<<skill
    expect(worker.search_vacancies[0]).to eq vacancy_programmer
  end

  it " doesnt search  for those who doesnt have skills" do
    vacancy_programmer.skills<<skill
    expect(worker.search_vacancies[0]).to be_nil
  end


end
