require 'spec_helper'

RSpec.describe 'Vandelay::Integrations::PatientRecords', type: :service do

  describe "PatientRecords" do

    it "should return patient record for VendorOne" do
      patient = Vandelay::Models::Patient.with_id(2)
      service = Vandelay::Services::PatientRecords.new
      records = service.get_records(patient)
      expect(patient.records_vendor).to eq('one')
      expect(records[:patient_id]).to eq(patient.id)
    end

    it "should return patient record for VendorTwo" do
      patient = Vandelay::Models::Patient.with_id(3)
      service = Vandelay::Services::PatientRecords.new
      records = service.get_records(patient)
      expect(patient.records_vendor).to eq('two')
      expect(records[:patient_id]).to eq(patient.id)
    end

  end
end
