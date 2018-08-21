json.extract! user, :id, :email, :name, :role, :invited_at, :created_at, :updated_at
json.url user_url(user, format: :json)
