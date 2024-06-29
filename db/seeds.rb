description = <<-DESCRIPTION
<div style="text-align: start;color: rgb(34, 34, 34);background-color: rgb(255, 255, 255);font-size: 1rem !important;">
    <div>Dale View - A beautiful 2 bedroom A/C bungalow set amongst nature with a 180 degree panoramic view of hills and the Kundalika River in the foreground. A beautiful get away for you and your family. Food can be ordered at home from the nearby Resort or get home cooked food prepared by a Cook who supplies food in our Complex. The Bungalow is on a hill with breathtaking view. Enjoy the serenity of the place during your visit and destress!</div>
</div>
<div style="text-align: start;color: rgb(34, 34, 34);background-color: rgb(255, 255, 255);font-size: 1rem !important;">
    <div>
        <div>
            <h3 tabindex="-1" style="color: inherit;font-size: 1em;">The space</h3>
        </div>The guests can make use of 2 air conditioned bedrooms, 1 air conditioned hall, 2 bathrooms (additional 3rd one behind the bungalow) and of course the kitchen. For sightseeing there is the famous Birla Ganesh Temple at Salav, Kashid beach, Revdanda town, Murud Janjira Beach all within a driving distance of 15-45 minutes. Nature lovers can go hiking in the hills of Phansad Wild Life Santuary. Very scenic, very peaceful surroundings and utter bliss to be woken up amongst the sounds of birds!! The Bungalow is situated on the Revdanda - Roha Road (8 kms from Revdanda)
    </div>
</div>
<div style="text-align: start;color: rgb(34, 34, 34);background-color: rgb(255, 255, 255);font-size: 1rem !important;">
    <div>
        <div>
            <h3 tabindex="-1" style="color: inherit;font-size: 1em;">Guest access</h3>
        </div>The whole bungalow is there for your use. Common car park. Swimming pool at a nearby Resort may be open to you for a nominal fee.
    </div>
</div>
<div style="text-align: start;color: rgb(34, 34, 34);background-color: rgb(255, 255, 255);font-size: 1rem !important;">
    <div>
        <div>
            <h3 tabindex="-1" style="color: inherit;font-size: 1em;">Other things to note</h3>
        </div>The bungalow is situated on a Hill and there are twenty steps to reach the Bungalow. Hence, not suitable for invalids or with persons with acute health issues.
    </div>
</div>
DESCRIPTION

pictures = []
20.times do |i|
  pictures << URI.parse(Faker::LoremFlickr.image).open
end

user = User.create!({
  email: 'test1@gmail.com',
  password: '123456',
  name: Faker::Lorem.unique.sentence(word_count: 3),
  address_1: Faker::Address.street_address,
  address_2: Faker::Address.street_name,
  city: Faker::Address.city,
  state: Faker::Address.state,
  country: Faker::Address.country
})
user.picture.attach(io: pictures[0], filename: user.name)

19.times do |i|
  random_user = User.create!({
    email: "test#{i+2}@gmail.com",
    password: '123456',
    name: Faker::Lorem.unique.sentence(word_count: 3),
    address_1: Faker::Address.street_address,
    address_2: Faker::Address.street_name,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country
  })
  random_user.picture.attach(io: pictures[i+1], filename: user.name)
end

6.times do |i|
  property = Property.create!({
    name: Faker::Lorem.unique.sentence(word_count: 3),
    description: description,
    headline: Faker::Lorem.unique.sentence(word_count: 6),
    address_1: Faker::Address.street_address,
    address_2: Faker::Address.street_name,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
    price: Money.from_amount((50..100).to_a.sample, 'USD'),
    bedroom_count: (2..5).to_a.sample,
    bed_count: (4..10).to_a.sample,
    guest_count: (4..20).to_a.sample,
    bathroom_count: (1..4).to_a.sample,
  })

  property.images.attach(io: File.open("db/images/property_#{i + 1}.png"), filename: property.name)
  property.images.attach(io: File.open("db/images/property_7.png"), filename: property.name)
  property.images.attach(io: File.open("db/images/property_8.png"), filename: property.name)
  property.images.attach(io: File.open("db/images/property_9.png"), filename: property.name)
  property.images.attach(io: File.open("db/images/property_10.png"), filename: property.name)
  property.images.attach(io: File.open("db/images/property_11.png"), filename: property.name)
  property.images.attach(io: File.open("db/images/property_12.png"), filename: property.name)

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
      user: User.all.sample
    })
  end
end