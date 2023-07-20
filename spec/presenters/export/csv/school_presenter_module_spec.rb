require "rails_helper"

RSpec.describe Export::Csv::SchoolPresenterModule do
  let(:project) { build(:conversion_project, urn: 121813, establishment: known_establishment) }
  subject { SchoolPresenterModuleTestClass.new(project) }

  it "presents the school urn" do
    expect(subject.school_urn).to eql "121813"
  end

  it "presents the school DfE number" do
    expect(subject.school_dfe_number).to eql "941/2025"
  end

  it "presents the school name" do
    expect(subject.school_name).to eql "Deanshanger Primary School"
  end

  it "presents the school type" do
    expect(subject.school_type).to eql "Community school"
  end

  it "presents the school address" do
    expect(subject.school_address_1).to eql "The Green"
    expect(subject.school_address_2).to eql "Deanshanger"
    expect(subject.school_address_3).to eql "Deanshanger Primary School, the Green, Deanshanger"
    expect(subject.school_address_town).to eql "Milton Keynes"
    expect(subject.school_address_county).to eql "Buckinghamshire"
    expect(subject.school_address_postcode).to eql "MK19 6HJ"
  end

  def known_establishment
    double(
      Api::AcademiesApi::Establishment,
      urn: 121813,
      name: "Deanshanger Primary School",
      dfe_number: "941/2025",
      type: "Community school",
      address_street: "The Green",
      address_locality: "Deanshanger",
      address_additional: "Deanshanger Primary School, the Green, Deanshanger",
      address_town: "Milton Keynes",
      address_county: "Buckinghamshire",
      address_postcode: "MK19 6HJ"
    )
  end
end

class SchoolPresenterModuleTestClass
  include Export::Csv::SchoolPresenterModule

  def initialize(project)
    @project = project
  end
end