require "vandelay/integrations/base"

module Vandelay
  module Integrations
    class VendorTwo < Base

      def get_token(data)
        data = JSON.parse(data)
        data['auth_token']
      end

      def build_record_response(data)
        data = JSON.parse(data)
        {
          province: data['province_code'],
          allergies: data['allergies_list'],
          num_medical_visits: data['medical_visits_recently']
        }
      end

      def token_url
        "http://#{@base_url}/auth_tokens/1"
      end

      def patient_url
        "http://#{@base_url}/records/#{@patient.vendor_id}"
      end

    end
  end
end
