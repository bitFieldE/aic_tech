body =
  "マッチングアプリでブログ機能を追加してみました。\n\n" +
  "他のマッチングアプリを見ているとブログ機能やつぶやき機能がほとんどついていなかった" +
  "ので勉強の意味でも他のマッチングアプリを作るためにもブログ機能を追加してみました。\n\n" +
  "インスタグラムのようなユーザーが写真投稿によってデザインができる仕様にしていけたらと" +
  "考えております。"

  @users = User.all

  @users.each do |user|
    0.upto(5) do |idx|
      blog = Blog.create(
        author: user,
        title: "プログラミングでマッチングアプリを作ってみた:#{idx}",
        body: body,
        posted_at: 10.days.ago.advance(days: idx),
        status: %w(draft user_list_only public)[idx % 3]
      )

      if user.gender == 1
        %w(Nana Kana Sayaka Shiori Rui).each do |name|
          liker = User.find_by(name: name)
          liker.liked_blogs << blog
        end
      end
    end
  end
