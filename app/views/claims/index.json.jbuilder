json.array!(@claims) do |claim|
  json.extract! claim, :id, :key, :first_name, :last_name, :product_name, :certificate_url, :credit_type, :claimed_credit, :survey_data
  json.url claim_url(claim, format: :json)
end
