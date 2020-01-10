FactoryBot.define do
  factory :user do
    sequence(:name) {|n|"TestName#{n}"}
    sequence(:email) {|n|"TestName#{n}@example.com"}
    birthday {"1980-01-01"}
    gender {1}
    sequence(:area) {|n| User.areas.keys[n]}
    sequence(:occupation) {|n| User.occupations.keys[n]}
    introduction {"TestText"}
    voice {"TestChat"}
    administrator {1}
    password {"test"}
    password_confirmation {"test"}
  end
end
