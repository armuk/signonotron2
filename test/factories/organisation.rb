FactoryGirl.define do
  factory :organisation do
    sequence(:api_id) { |n| "https://whitehall-admin.production.alphagov.co.uk/api/organisations/ministry-of-funk-#{n}000" }
    sequence(:web_url) { |n| "https://www.gov.uk/government/ministry-of-funk-#{n}000" }
    sequence(:name) { |n| "Ministry of Funk #{n}000" }
    organisation_type "Ministerial Department"
  end
end
