require 'vandelay/services/patients'
require 'vandelay/services/patient_records'

module Vandelay
  module REST
    module PatientsPatient

      def self.get_by_id(id_patient)
        service = Vandelay::Services::Patients.new
        result = service.retrieve_one(id_patient.to_i)
        if result.nil?
          { success: false, status: 404, error: 'no patient' }
        else
          { success: true, status: 200, record: result }
        end
      end

      def self.registered(app)
        app.get '/patients/:id' do
          result = Vandelay::REST::PatientsPatient::get_by_id(params[:id])
          status result[:status]
          if result[:success]
            json(result[:record].to_h)
          else
            json({error: result[:error]})
          end
        end

        app.get '/patients/:patient_id/record' do
          result = Vandelay::REST::PatientsPatient::get_by_id(params[:patient_id])
          status result[:status]
          if result[:success]
            patient = result[:record]
            service = Vandelay::Services::PatientRecords.new
            records = service.get_records(patient)
            json(records)
          else
            json({error: result[:error]})
          end
        end
      end
    end
  end
end
