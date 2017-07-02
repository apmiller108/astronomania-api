require 'rails_helper'

describe 'Creating Scheduled Jobs' do
  after :each { Sidekiq::Worker.clear_all }

  context 'admin user' do
    let :user { create :user, :admin }

    context 'valid job' do
      let :valid_params do
        {
          job: {
            job_type: 'import'
          }
        }
      end

      before :each do
        post admin_jobs_path,
             params: valid_params,
             headers: authenticated_headers(user),
             as: :json
      end

      it 'responds with a 201 status' do
        expect(response).to have_http_status :created
      end

      it 'creates a job to import asteroids' do
        expect(Importer::AsteroidWorker.jobs.count).to eq 1
      end

      it 'creates a job to import apod' do
        expect(Importer::ApodWorker.jobs.count).to eq 1
      end
    end

    context 'invalid job' do
      let :invalid_params do
        {
          job: {
            job_type: 'non-existent job'
          }
        }
      end

      it 'responds with a 422 status' do
        post admin_jobs_path,
             params: invalid_params,
             headers: authenticated_headers(user),
             as: :json

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  context 'standard user' do
    let :user { create :user }

    it 'responds with 401 response' do
      post admin_jobs_path,
           params: { job: { job_type: 'import ' } },
           headers: authenticated_headers(user),
           as: :json

      expect(response).to have_http_status :unauthorized
    end
  end
end
