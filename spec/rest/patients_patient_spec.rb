require 'spec_helper'

RSpec.describe 'Vandelay::REST::PatientsPatient', type: :request do

  let(:app) { RESTServer}

  describe "GET /patients/:id" do
    it "should get patient by id" do
      get "/patients/1"
      response_body = JSON.parse(last_response.body)
      status = last_response.status
      expect(response_body['id']).to eq('1')
      expect(status).to eq(200)
    end

    it "should return 'no patient' error if patient not found for given id" do
      get "/patients/4"
      response_body = JSON.parse(last_response.body)
      status = last_response.status
      expect(response_body['error']).to eq('no patient')
      expect(status).to eq(404)
    end
  end

  describe "GET /patients/:id/record" do
    it "should return 'no patient' error if patient not found for given id" do
      get "/patients/5/record"
      response_body = JSON.parse(last_response.body)
      status = last_response.status
      expect(response_body['error']).to eq('no patient')
      expect(status).to eq(404)
    end

    it "should return record for VendorOne" do
      get "/patients/2/record"
      response_body = JSON.parse(last_response.body)
      status = last_response.status
      expect(response_body['patient_id']).to eq("2")
      expect(response_body['province']).to eq("QC")
      expect(status).to eq(200)
    end

    it "should return record for VendorTwo" do
      get "/patients/3/record"
      response_body = JSON.parse(last_response.body)
      status = last_response.status
      expect(response_body['patient_id']).to eq("3")
      expect(response_body['province']).to eq("ON")
      expect(status).to eq(200)
    end
  end
end