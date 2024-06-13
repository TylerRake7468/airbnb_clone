# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Property.create!([
    {
        name: "Marwad Villa",
        headline: "Marwadi Vila, Marwad Junction",
        description: "asfkaj jojasdv jj o js naj sdj nsdvk njkjd ",
        address_1: "Suryanagar",
        address_2: "Marwad junction",
        city: "Pali",
        state: "Rajasthan",
        country: "India"
    },
    {
        name: "Palariya Villa",
        headline: "Palariya Vila, Marwad Junction",
        description: "asfsaf asf askjs aksjd kaj jojasdv jj o js naj sdj nsdvk njkjd ",
        address_1: "Suryanagar",
        address_2: "New Marwad junction",
        city: "Pali",
        state: "Rajasthan",
        country: "India"
    }
])