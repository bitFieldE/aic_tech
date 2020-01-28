names = %w(Kota Nana Tsubasa Kana Shintaro Rui Ryuhei Shiori Atsuki Sayaka)
text = "SNSは初心者なのでお手柔らかにお願い致します。"

0.upto(9) do |idx|
  User.create(
    name: names[idx],
    email: "#{names[idx]}@example.com",
    birthday: "1994-02-21",
    gender: [1, 2][idx % 2],
    area: User.areas.keys[idx + 1],
    occupation: User.occupations.keys[idx + 1],
    introduction: text,
    voice: "コーヒーブレイク",
    administrator: (idx == 0),
    password: "password#{idx}",
    password_confirmation: "password#{idx}"
  )
end

0.upto(29) do |idx|
  User.create(
    name: "DemoUser#{idx + 1}",
    email: "DemoUser#{idx + 1}@example.com",
    birthday: "1995-04-13",
    gender: [1, 2][idx % 2],
    area: User.areas.keys[idx],
    occupation: User.occupations.keys[(idx+3)/2],
    introduction: "私が国家権力です。",
    voice: "シュガーソルト",
    administrator: false,
    password: "DemoUser#{idx + 1}",
    password_confirmation: "DemoUser#{idx + 1}"
  )
end

%w(Nana Kana Sayaka).each do |female|
    woman = User.find_by(name: female)
  %w(Shintaro Ryuhei Atsuki).each do |male|
    man = User.find_by(name: male)
    woman.follow(man)
    man.follow(woman)
  end
end
