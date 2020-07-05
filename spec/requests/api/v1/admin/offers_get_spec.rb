require 'rails_helper'

describe "get all offers route", :type => :request do
  let!(:offers) {FactoryBot.create_list(:offers, 5)}

  authorization = ActionController::HttpAuthentication::Basic.encode_credentials('admin123','admin123')
  before {get '/api/v1/admin/offers', headers: { 'HTTP_AUTHORIZATION' => authorization }}

  it 'returns all offers' do
    subject = JSON.parse(response.body)

    expect(subject["data"].size).to eq(5)
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end
