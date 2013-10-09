require 'gds_api/organisations'

class OrganisationsFetcher

  def call
    organisations.each { |org_data| update_or_create_organisation(org_data) }
  end

private

  def organisations
    base_uri = Plek.current.find('whitehall-admin')
    GdsApi::Organisations.new(base_uri).organisations.with_subsequent_pages
  end

  def update_or_create_organisation(org_data)
    organisation = Organisation.find_or_initialize_by_api_id(org_data.id)
    update_data = {
      web_url: org_data.web_url,
      name: org_data.title,
      organisation_type: org_data.format,
    }
    organisation.update_attributes!(update_data)
  rescue ActiveRecord::RecordInvalid => e
    raise "Couldn't save organisation #{org_data.id} because: #{e.message}"
  end
end
