FactoryBot.define do
  factory :article do
    sequence(:title) {|n| "TestTitle#{n}"}
    sequence(:body) {|n| "TestText#{n}"}
    released_at {8.days.ago.advance(days: 3)}
    expired_at {2.days.ago.advance(days: 3)}
    user_list_only {1}

    trait :invalid do
      title {nil}
    end
  end

  factory :article_b, class: Article do
    title { "TestTitle B"}
    body {"TestText B"}
    released_at {8.days.ago.advance(days: 3)}
    expired_at {2.days.ago.advance(days: 3)}
    user_list_only {1}

    trait :invalid do
      title {nil}
    end
  end
end
