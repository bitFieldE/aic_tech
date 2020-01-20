FactoryBot.define do
  factory :user do
    sequence(:name) {|n| "TestUserName#{n}"}
    sequence(:email) {|n| "TestUserEmail#{n}@example.com"}
    birthday {"1980-01-01"}
    gender {1}
    introduction {"TestText"}
    voice {"TestChat"}
    sequence(:area) {|n| User.areas.keys[n%2]}
    sequence(:occupation) {|n| User.occupations.keys[n%2]}
    administrator {1}
    sequence(:password) {|n| "testuser#{n}"}
    sequence(:password_confirmation) {|n| "testuser#{n}"}
    trait :invalid do
      name {nil}
    end
  end

  factory :john, class: User do
    name {"John"}
    email {"John@example.com"}
    birthday {"1990-03-31"}
    gender {1}
    introduction {"TestText"}
    voice {"TestChat"}
    sequence(:area) {|n| User.areas.keys[n%2]}
    sequence(:occupation) {|n| User.occupations.keys[n%2]}
    administrator {1}
    password {"john"}
    password_confirmation {"john"}
    trait :invalid do
      name {nil}
    end
  end

  factory :mary, class: User do
    name {"Mary"}
    email {"Mary@example.com"}
    birthday {"1990-03-31"}
    gender {2}
    introduction {"TestText"}
    voice {"TestChat"}
    sequence(:area) {|n| User.areas.keys[n%2]}
    sequence(:occupation) {|n| User.occupations.keys[n%2]}
    administrator {1}
    password {"mary"}
    password_confirmation {"mary"}
  end
end
