require 'rails_helper'

RSpec.describe Skill, type: :model do
  it { expect(subject).to validate_presence_of :skill }
  it { expect(subject).to validate_uniqueness_of :skill }
end
