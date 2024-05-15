class Geolocation < ApplicationRecord
  CONTINENT_CODES = %w[AF AS EU NA SA OC AN].freeze

  validates :continent_code, inclusion: { in: CONTINENT_CODES }
  validates :country_code, inclusion: { in: ISO3166::Country.all.map(&:alpha2) }
  validates :ip, format: { with: Resolv::AddressRegex }
  validates :latitude, inclusion: -90..90
  validates :longitude, inclusion: -180..180
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }
end
