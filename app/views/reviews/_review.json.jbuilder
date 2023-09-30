json.extract! review, :id, :feedback, :created_at, :updated_at
json.url review_url(review, format: :json)
