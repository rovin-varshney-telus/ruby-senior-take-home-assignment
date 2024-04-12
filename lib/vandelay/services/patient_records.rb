require 'vandelay/integrations/vendor_one'
require 'vandelay/integrations/vendor_two'

module Vandelay
  module Services
    class PatientRecords
      def get_records(patient)
        vendor_identifier = patient.records_vendor
        vendor_data = if(vendor_class(vendor_identifier))
          vendor = Object.const_get("Vandelay::Integrations::#{vendor_class(vendor_identifier)}")
          vendor.new(patient, vendor_identifier).fetch_data
        else
          no_vendor
        end
        vendor_data.merge({patient_id: patient.id})
      end

      private

      def no_vendor
        {
          province: nil,
          allergies: [],
          num_medical_visits: nil
        }
      end

      def vendor_class(vendor_identifier)
        case vendor_identifier
        when 'one'
          'VendorOne'
        when 'two'
          'VendorTwo'
        end
      end
    end
  end
end
