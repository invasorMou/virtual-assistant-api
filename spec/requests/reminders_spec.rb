require 'rails_helper'

RSpec.describe 'Reminders API', type: :request do
  let(:user) { create(:user) }
  let!(:reminders) { create_list(:reminder, 10, created_by: user.id) }
  let(:reminder_id) { reminders.first.id }
  let(:headers) { valid_headers }
  
  describe 'GET /reminders' do
    before { get '/reminders', params: {}, headers: headers }
    
    it 'returns reminders' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end
    
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
  
  describe 'GET /reminders/:id' do
    before { get "/reminders/#{reminder_id}", params: {}, headers: headers }
    
    context 'when the record exists' do
      it 'returns the reminder' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(reminder_id)
      end
      
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    
    context 'when the record does not exist' do
      let(:reminder_id) { 100 }
      
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      
      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Reminder/)
      end
    end
  end
  
  describe 'POST /reminders' do
    let(:valid_attributes) do 
      { title: 'Finish API project', created_by: user.id.to_s }.to_json 
    end
    
    context 'when the request is valid' do
      before { post '/reminders', params: valid_attributes, headers: headers }
      
      it 'creates a reminder' do
        expect(json['title']).to eq('Finish API project')
      end
      
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    
    context 'when te request is invalid' do
      let(:invalid_attributes) { { title: nil }.to_json }
      before { post '/reminders', params: invalid_attributes, headers: headers }
      
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      
      it 'returns a validation failure message' do
        expect(json['message']).to match(/Validation failed: Title can't be blank/)
      end
    end
  end
  
  describe 'PUT /reminders/:id' do
    let(:valid_attributes) { { title: 'Work out' }.to_json }
    
    context 'whent the record exists' do
      before { put "/reminders/#{reminder_id}", params: valid_attributes, headers: headers }
      
      it 'updates the record' do
        expect(response.body).to be_empty
      end
      
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
  
  describe 'DELETE /reminders/:id' do
    before { delete "/reminders/#{reminder_id}", params: {}, headers: headers }
    
    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end