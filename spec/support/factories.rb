FactoryGirl.define do
  factory :certificate do
    claimable_uri "12"
    claimable_type "Product"
    template_pdf "template.pdf"
    certificate_type "CME"
    available_credit "3.5"
  end

  factory :claim do
    key "ABCD1234"
    first_name "First"
    last_name "Last"
    certificate_url "/template.pdf"
    credit_type "CME"
    product_name "Fake Course"
    claimed_credit "2.5"
    # survey_data
  end

  factory :survey do
    title "User Information"
    # data
  end

  factory :prerequisite do
    certificate
    survey
    order 1
  end
end