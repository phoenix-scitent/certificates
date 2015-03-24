json.array!(@prerequisites) do |prerequisite|
  json.extract! prerequisite, :id, :certificate_id, :survey_id, :survey_order
  json.url prerequisite_url(prerequisite, format: :json)
end
