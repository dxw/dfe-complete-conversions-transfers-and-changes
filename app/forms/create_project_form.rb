class CreateProjectForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveRecord::AttributeAssignment

  SHAREPOINT_URLS = %w[educationgovuk-my.sharepoint.com educationgovuk.sharepoint.com].freeze

  class NegativeValueError < StandardError; end

  attribute :urn, :integer
  attribute :incoming_trust_ukprn, :integer
  attribute :outgoing_trust_ukprn, :integer
  attribute :establishment_sharepoint_link
  attribute :trust_sharepoint_link
  attribute :user

  attr_reader :advisory_board_date

  validates :urn, presence: true, urn: true
  validates :incoming_trust_ukprn, presence: true, ukprn: true
  validates :advisory_board_date, presence: true
  validates :advisory_board_date, date_in_the_past: true

  validates :establishment_sharepoint_link, presence: true, url: {hostnames: SHAREPOINT_URLS}
  validates :trust_sharepoint_link, presence: true, url: {hostnames: SHAREPOINT_URLS}

  validate :establishment_exists, if: -> { urn.present? }
  validate :trust_exists, if: -> { incoming_trust_ukprn.present? }

  validate :multiparameter_date_attributes_values

  def region
    @region = establishment.region_code
  end

  def advisory_board_date=(hash)
    @advisory_board_date = Date.new(value_at_position(hash, 1), value_at_position(hash, 2), value_at_position(hash, 3))
  rescue NoMethodError
    nil
  rescue TypeError, Date::Error, NegativeValueError
    @attributes_with_invalid_values << :advisory_board_date
  end

  private def establishment
    @establishment || fetch_establishment(urn)
  end

  private def establishment_exists
    establishment
  rescue Api::AcademiesApi::Client::NotFoundError
    errors.add(:urn, :no_establishment_found)
  end

  private def trust_exists
    result = Api::AcademiesApi::Client.new.get_trust(incoming_trust_ukprn)
    raise result.error if result.error.present?
  rescue Api::AcademiesApi::Client::NotFoundError
    errors.add(:incoming_trust_ukprn, :no_trust_found)
  end

  private def fetch_establishment(urn)
    result = Api::AcademiesApi::Client.new.get_establishment(urn)
    raise result.error if result.error.present?

    result.object
  end

  private def urn_unique_for_in_progress_transfers
    errors.add(:urn, :duplicate) if Transfer::Project.not_completed.where(urn: urn).any?
  end

  private def value_at_position(hash, position)
    value = hash[position]
    return NegativeValueError if value.to_i < 0
    value
  end

  private def multiparameter_date_attributes_values
    return if @attributes_with_invalid_values.empty?
    @attributes_with_invalid_values.each { |attribute| errors.add(attribute, :invalid) }
  end
end