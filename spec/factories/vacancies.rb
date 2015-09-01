FactoryGirl.define do

factory :vacancy do
    title "MyString"
    till "2015-08-19 05:22:04"
    salary "9.99"
    contacts

    trait :with_skills do
      after(:create) do |vacancy|
         vacancy.skills << create(:skill, skill: "Testing")
      end
    end
  end
end


# trait :with_gps_position do
#      after(:create) do |modem_registry|
#        modem_registry.gps_positions << create(:gps_position)
#      end
#    end
