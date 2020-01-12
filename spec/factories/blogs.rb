FactoryBot.define do
  factory :blog do
    title { "プログラミングでマッチングアプリを作ってみた" }
    body { "０から１を生み出せれば１００までいくのは簡単" }
    posted_at { 10.days.ago.advance(days: 3)}
    sequence(:status) { |n| %w(draft user_list_only public)[n % 3]}
  end
end
