FactoryBot.define do
  factory :user do
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
      password {nil}
    end
  end

  factory :tom, class: User do
    name {"Tom"}
    email {"Tom@example.com"}
    birthday {"1990-03-31"}
    gender {1}
    introduction {"TestText"}
    voice {"TestChat"}
    sequence(:area) {|n| User.areas.keys[n%2]}
    sequence(:occupation) {|n| User.occupations.keys[n%2]}
    administrator {1}
    password {"tom"}
    password_confirmation {"tom"}
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
