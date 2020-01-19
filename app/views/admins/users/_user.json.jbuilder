json.extract! user, :id, :name, :email, :birthday, :sex, :introduction, :administrator, :created_at, :updated_at
json.url user_url(user, format: :json)
