require "vandelay/integrations/base"

module Vandelay
  module Integrations
    class VendorOne < Base

      def get_token(data)
        data = JSON.parse(data)
        data['token']
      end

      def build_record_response(data)
        data = JSON.parse(data)
        {
          province: data['province'],
          allergies: data['allergies'],
          num_medical_visits: data['recent_medical_visits']
        }
      end

      def token_url
        "http://#{@base_url}/auth/1"
      end

      def patient_url
        "http://#{@base_url}/patients/#{@patient.vendor_id}"
      end

    end
  end
end
