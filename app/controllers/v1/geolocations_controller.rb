module V1
  class GeolocationsController < ApplicationController
    before_action :sanitize_address!

    def create
      Geolocations::Create.new(@address).call

      render_ok 'Geolocation successfully created!'
    rescue => e
      render_internal_server_error e
    end

    def show
      geolocation = Geolocations::Find.new(@address, ipstack_lookup: true).call

      render json: geolocation
    rescue => e
      render_internal_server_error e
    end

    def destroy
      geolocation = Geolocations::Find.new(@address).call
      geolocation.destroy!

      render_ok 'Geolocation destroyed!'
    rescue => e
      render_internal_server_error e
    end

    private

    def sanitize_address!
      @address = NetworkAddress.new(params[:id]).sanitize!
    rescue => e
      render_internal_server_error e
    end
  end
end
