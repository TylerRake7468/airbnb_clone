20.times do
    Property.create!([
        name: Faker::Lorem.unique.sentence(word_count: 3),
        headline: Faker::Lorem.unique.sentence(word_count: 6),
        description: Faker::Lorem.paragraph(sentence_count: 10),
        address_1: Faker::Address.street_name,
        address_2: Faker::Address.street_address,
        city: Faker::Address.city_prefix,
        state: Faker::Address.state,
        country: Faker::Address.country,
        price: Money.from_amount((50..100).to_a.sample, "USD")
    ])
end