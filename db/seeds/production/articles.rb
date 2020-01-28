body =
  "同日から事前登録を受け付け、iOS版を9月31日、Andorid版を10月28日にリリースする予定。\n\n" +
  "ダウンロードは無料だが、利用する場合は、男女ともに入会金と月額料金（ともに税込9800円）が必要。\n\n追加料金はかからない。" +
  "結婚願望の強い若者が主なターゲット。\n\n" +
  "地方では23～28歳、大都市圏では30歳前後の利用を想定するが、年齢に上限は設けない。"

0.upto(9) do |idx|
  Article.create(
    title: "新作マッチングアプリリリース#{idx + 1}",
    body: body,
    released_at: 8.days.ago.advance(days: idx),
    expired_at: 2.days.ago.advance(days: idx),
    user_list_only: (idx % 3 == 0)
  )
end

0.upto(29) do |idx|
  Article.create(
    title: "ニュース#{idx + 1}",
    body: "テキスト",
    released_at: 100.days.ago.advance(days: idx),
    expired_at: nil,
    user_list_only: false
  )
end
