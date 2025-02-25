FactoryBot.define do
  factory :local_authority do
    name { "Cumbria County Council" }
    code { rand(100..9999).to_s }
    address_1 { "Cumbria House" }
    address_2 { "117 Botchergate" }
    address_3 { nil }
    address_town { "Carlisle" }
    address_county { "Cumbria" }
    address_postcode { "CA1 1RD" }
  end
end
