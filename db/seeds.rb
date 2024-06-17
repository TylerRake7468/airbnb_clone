user = User.create!({
    email: "test1@gmail.com",
    password: "123456"
})

6.times do |i|
    property = Property.create!({
        name: Faker::Lorem.unique.sentence(word_count: 3),
        headline: Faker::Lorem.unique.sentence(word_count: 6),
        description: Faker::Lorem.paragraph(sentence_count: 10),
        address_1: Faker::Address.street_name,
        address_2: Faker::Address.street_address,
        city: Faker::Address.city_prefix,
        state: Faker::Address.state,
        country: Faker::Address.country,
        price: Money.from_amount((50..100).to_a.sample, "USD")
    })
    property.images.attach(io: File.open("db/images/property_#{i+1}.png"), filename: property.name)
    property.images.attach(io: File.open("db/images/property_#{i+7}.png"), filename: property.name)

    ((5..10).to_a.sample).times do
        Review.create!({
            content: Faker::Lorem.paragraph(sentence_count: 10),
            cleanliness_rating: (1..5).to_a.sample,
            accuracy_rating: (1..5).to_a.sample,
            checkin_rating: (1..5).to_a.sample,
            communication_rating: (1..5).to_a.sample,
            location_rating: (1..5).to_a.sample,
            value_rating: (1..5).to_a.sample,
            property: property,
            user: user
        })
    end

end