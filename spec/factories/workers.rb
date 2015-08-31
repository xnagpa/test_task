FactoryGirl.define do
sequence :contacts do |n|
    "user#{n}@test.com"
end
  factory :worker do
    name "Erast Petrovich Fandorin"
    contacts
    status "MyString"
    salary "9.99"
  end

end
