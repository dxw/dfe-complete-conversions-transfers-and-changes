class Export::Conversions::RpaSugAndFaLettersCsvExportService < Export::CsvExportService
  COLUMN_HEADERS = %i[
    school_urn
    school_name
    school_type
    school_phase
    school_dfe_number
    school_address_1
    school_address_2
    school_address_3
    school_address_town
    school_address_county
    school_address_postcode
    school_main_contact_name
    school_main_contact_role
    school_main_contact_email
    chair_of_governors_name
    chair_of_governors_email
    academy_urn
    academy_ukprn
    academy_name
    academy_dfe_number
    academy_address_1
    academy_address_2
    academy_address_3
    academy_address_town
    academy_address_county
    academy_address_postcode
    reception_to_six_years
    seven_to_eleven_years
    twelve_or_above_years
    incoming_trust_identifier
    incoming_trust_name
    incoming_trust_companies_house_number
    incoming_trust_address_1
    incoming_trust_address_2
    incoming_trust_address_3
    incoming_trust_address_town
    incoming_trust_address_county
    incoming_trust_address_postcode
    incoming_trust_main_contact_name
    incoming_trust_main_contact_role
    incoming_trust_main_contact_email
    director_of_child_services_name
    director_of_child_services_role
    director_of_child_services_email
    local_authority_code
    local_authority_name
    region
    local_authority_address_1
    local_authority_address_2
    local_authority_address_3
    local_authority_address_town
    local_authority_address_county
    local_authority_address_postcode
    mp_constituency
    mp_name
    mp_email
    mp_address_1
    mp_address_2
    mp_address_3
    mp_address_postcode
    advisory_board_date
    conversion_type
    academy_order_type
    two_requires_improvement
    sponsored_grant_type
    risk_protection_arrangement
    risk_protection_arrangement_reason
    provisional_conversion_date
    conversion_date
    all_conditions_met
    date_academy_opened
    assigned_to_name
    assigned_to_email
  ]

  def initialize(projects)
    @projects = projects
  end
end