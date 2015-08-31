require 'rails_helper'

RSpec.describe Vacancy, type: :model do
  it { expect(subject).to validate_presence_of :title}
  it { expect(subject).to validate_presence_of :contacts}
  it { expect(subject).to validate_presence_of :salary }
  it { expect(subject).to validate_presence_of :till }

  it { expect(subject).to allow_value("email@addresse.foo").for(:contacts) }
  it { expect(subject).to allow_value("ema13il@addresse.foo").for(:contacts) }
  it { expect(subject).to_not allow_value("emaaddresse.foo").for(:contacts) }
  it { expect(subject).to allow_value("+7916-888-96-90").for(:contacts) }
  it { expect(subject).to_not allow_value("+791696-90").for(:contacts) }
end
