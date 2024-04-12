require "net/http"
require 'vandelay/util/cache'

module Vandelay
  module Integrations
    class Base
      def initialize(patient, vendor_identifier)
        vendor_config = Vandelay.config.dig('integrations', 'vendors', patient.records_vendor)
        @patient = patient
        @base_url = vendor_config['api_base_url']
        @cache = Vandelay::Util::Cache.new("#{vendor_identifier}-#{patient.vendor_id}")
      end

      def fetch_data
        if(@cache.get_val)
          JSON.parse(@cache.get_val)
        else
          uri = URI.parse(patient_url)
          http = Net::HTTP.new(uri.host, uri.port)
          request = Net::HTTP::Get.new(uri.request_uri)
          request['Authorization'] = "Bearer: #{auth_token}"
          response = http.request(request)
          @cache.set_val(build_record_response(response.body))
        end
      end

      private

      def auth_token
        uri_token = URI.parse(token_url)
        response = Net::HTTP.get_response(uri_token)
        get_token(response.body)
      end
    end
  end
end
