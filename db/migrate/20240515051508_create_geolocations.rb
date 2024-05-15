class CreateGeolocations < ActiveRecord::Migration[7.0]
  def change
    create_table :geolocations do |t|
      t.string :ip
      t.string :url
      t.string :continent_code
      t.string :country_code
      t.float :latitude, precision: 10, scale: 6
      t.float :longitude, precision: 10, scale: 6

      t.timestamps
    end
  end
end
