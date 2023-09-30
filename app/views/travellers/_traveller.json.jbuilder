json.extract! user, :id, :name, :password, :email, :phone_number, :address, :credit_card_info, :created_at, :updated_at
json.url user_url(user, format: :json)
