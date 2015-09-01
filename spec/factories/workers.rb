FactoryGirl.define do
sequence :contacts do |n|
    "user#{n}@test.com"
end
  factory :worker do
    name "Erast Petrovich Fandorin"
    contacts
    status "MyString"
    salary "9.99"

    after(:create) do |worker|
         worker.skills << create(:mighty_skill)
     end

    # trait :with_programmer_skills do
    #   after(:create) do |worker|
    #      worker.skills << create(:skill, skill: "Testing")
    #   end
    # end
    #
    # trait :with_janitor_skills do
    #   after(:create) do |worker|
    #      worker.skills << create(:skill, skill: "Sanitize")
    #   end
    # end

  end

end
