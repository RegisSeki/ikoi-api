FactoryBot.define do
  factory :advertisers, class: Advertiser do
    name { Faker::Company.name }
    url { Faker::Internet.url }
  end

  factory :offers, class: Offer do
    association :advertiser, factory: :advertisers
    url { Faker::Internet.url }
    description { Faker::Lorem.characters }
    starts_at { Time.now }
  end
end
