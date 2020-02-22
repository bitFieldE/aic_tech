json.array!(@users) do |user|
  json.id user.id
  json.name user.name
  json.profile_picture user&.profile_picture.variant(resize: "300x300")
  json.age user.birthday
  json.area user.area
  json.occupation user.occupation
  json.voice user.voice
end
