require 'test_helper'
require 'gds_api/test_helpers/organisations'

class OrganisationsFetcherTest < ActiveSupport::TestCase
  include GdsApi::TestHelpers::Organisations

  test "it creates new organisations when none exist" do
    organisation_slugs = %w(ministry-of-fun, tea-agency)
    organisations_api_has_organisations(organisation_slugs)
    assert_equal(0, Organisation.count)

    OrganisationsFetcher.new.call

    assert_equal(2, Organisation.count)
  end

  test "it updates an existing organisation when its data changes" do
    @organisation = FactoryGirl.create(
      :organisation,
      api_id: 'https://www.gov.uk/api/organisations/ministry-of-fun',
      web_url: 'https://www.gov.uk/government/organisations/ministry-of-fun',
      name: 'Ministry Of Misery',
    )
    assert_equal(1, Organisation.count)

    organisation_slugs = %w(ministry-of-fun)
    organisations_api_has_organisations(organisation_slugs)

    OrganisationsFetcher.new.call

    assert_equal(1, Organisation.count)
    assert_not_nil(Organisation.find_by_name('Ministry Of Fun'))
  end

  test "it raises an error when it receives invalid data" do
    organisation_slugs = [""]
    organisations_api_has_organisations(organisation_slugs)

    assert_raises RuntimeError do
      OrganisationsFetcher.new.call
    end
  end

end
