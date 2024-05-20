# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Geolocation.create!(
  [
    {
      ip: '20.76.201.171',
      url: 'microsoft.com',
      continent_code: 'EU',
      country_code: 'NL',
      latitude: 52.309051513671875,
      longitude: 4.940189838409424
    },
    {
      ip: '52.94.236.248',
      url: 'amazon.com',
      continent_code: 'NA',
      country_code: 'US',
      latitude: 39.043701171875,
      longitude: -77.47419738769531
    },
    {
      ip: '157.240.229.35',
      url: 'facebook.com',
      continent_code: 'NA',
      country_code: 'US',
      latitude: 38.98371887207031,
      longitude: -77.38275909423828
    },
    {
      ip: '142.251.179.138',
      url: 'google.com',
      continent_code: 'NA',
      country_code: 'US',
      latitude: 37.419158935546875,
      longitude: -122.07540893554688
    },
    {
      ip: '17.253.144.10',
      url: 'apple.com',
      continent_code: 'NA',
      country_code: 'US',
      latitude: 37.330528259277344,
      longitude: -121.83822631835938
    }
  ]
)
