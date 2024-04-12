require 'spec_helper'

RSpec.describe 'Vandelay::Integrations::VendorOne', type: :service do
  let(:patient) { Vandelay::Models::Patient.with_id(2) }
  let(:token_api_response) { {"id": "1","token": "129e8ry23uhj23948rhu23"}.to_json}
  let(:vendor_one) { Vandelay::Integrations::VendorOne.new(patient, 'one') }
  let(:record_api_response) {
    {
      "province": "QC",
      "allergies": [
        "work",
        "conformity",
        "paying taxes"
      ],
      "recent_medical_visits": 1
    }.to_json
  }

  describe "VendorOne" do

    it "should fetch the auth_token from VendorOne /auth API response" do
      response = vendor_one.get_token(token_api_response)
      expect(response).to eq('129e8ry23uhj23948rhu23')
    end

    it "should build record response from VendorOne /patients/:vendor_id API" do
      response = vendor_one.build_record_response(record_api_response)
      expect(response).to eq({"province":"QC","allergies":["work","conformity","paying taxes"],"num_medical_visits":1})
    end

    it "should return token api url" do
      token_url = vendor_one.token_url
      expect(token_url).to eq("http://mock_api_one:80/auth/1")
    end

    it "should return patient api url" do
      token_url = vendor_one.patient_url
      expect(token_url).to eq("http://mock_api_one:80/patients/743")
    end

  end
end
