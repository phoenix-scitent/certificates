json.array!(@certificates) do |certificate|
  json.extract! certificate, :id, :claimable_uri, :claimable_type, :template_pdf, :template_background_image, :certificate_type, :available_credit, :expiration_date
  json.url certificate_url(certificate, format: :json)
end
