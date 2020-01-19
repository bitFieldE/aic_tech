FactoryBot.define do
  factory :blog do
    sequence(:title) {|n| "Blog test#{n}" }
    body { "Blog post" }
    posted_at {10.days.ago.advance(days: 3)}
    sequence(:status) { |n| %w(draft user_list_only public)[n % 3]}

    trait :invalid do
      title {nil}
      body {nil}
    end
  end

  factory :blog_2, class: Blog do
    title { "Blog2" }
    body { "post2" }
    posted_at {10.days.ago.advance(days: 3)}
    sequence(:status) { |n| %w(draft user_list_only public)[n % 3]}

    trait :invalid do
      title {nil}
      body {nil}
    end
  end
end
