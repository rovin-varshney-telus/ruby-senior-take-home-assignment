require 'spec_helper'

RSpec.describe 'Vandelay::Integrations::VendorTwo', type: :service do
  let(:patient) { Vandelay::Models::Patient.with_id(3) }
  let(:token_api_response) {{ "id": "1", "auth_token": "349rijed934r8ij123$=="}.to_json}
  let(:vendor_two) { Vandelay::Integrations::VendorTwo.new(patient, 'two') }
  let(:record_api_response) {
    {
      "province_code": "ON",
      "clinic_id": "7",
      "allergies_list": [
        "hair",
        "mean people",
        "paying the bill"
      ],
      "medical_visits_recently": 17
    }.to_json
  }

  describe "VendorTwo" do

    it "should fetch the auth_token from VendorOne /auth_token API response" do
      response = vendor_two.get_token(token_api_response)
      expect(response).to eq('349rijed934r8ij123$==')
    end

    it "should build record response from VendorTwo /records/:vendor_id API" do
      response = vendor_two.build_record_response(record_api_response)
      expect(response).to eq({"province":"ON","allergies":["hair","mean people","paying the bill"],"num_medical_visits":17})
    end

    it "should return token api url" do
      token_url = vendor_two.token_url
      expect(token_url).to eq("http://mock_api_two:80/auth_tokens/1")
    end

    it "should return patient api url" do
      token_url = vendor_two.patient_url
      expect(token_url).to eq("http://mock_api_two:80/records/16")
    end

  end
end
