json.array!(@responses) do |response|
  json.extract! response, :id, :user_uri, :payload
  json.url response_url(response, format: :json)
end
