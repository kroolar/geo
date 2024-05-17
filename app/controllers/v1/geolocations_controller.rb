module V1
  class GeolocationsController < ApplicationController
    before_action :validate_address!

    def show
      geolocation = Geolocations::Find.new(address, ipstack_lookup: true).call

      render json: geolocation
    rescue => e
      render_internal_server_error e
    end

    def destroy
      geolocation = Geolocations::Find.new(address).call
      geolocation.destroy!

      render_ok 'Geolocation destroyed!'
    rescue => e
      render_internal_server_error e
    end

    private

    def address
      @address ||= network_address.sanitize
    end

    def network_address
      @network_address ||= NetworkAddress.new(params[:id])
    end

    def validate_address!
      network_address.validate!
    rescue => e
      render_internal_server_error e
    end
  end
end
