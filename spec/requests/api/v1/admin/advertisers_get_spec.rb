require 'rails_helper'

describe "get all advertisers route", :type => :request do

  let!(:advertisers) {FactoryBot.create_list(:advertisers, 5)}

  authorization = ActionController::HttpAuthentication::Basic.encode_credentials('admin123','admin123')
  before {get '/api/v1/admin/advertisers', headers: { 'HTTP_AUTHORIZATION' => authorization }}

  it 'return all advertisers' do
    subject = JSON.parse(response.body)
    expect(subject["data"].size).to eq(5)
    expect(subject["data"][0]["name"]).not_to be_empty
    expect(subject["data"][0]["url"]).not_to be_empty
  end

  it 'return status code 200' do
    expect(response).to have_http_status(:success)
  end
end

describe "get advertiser by id route", :type => :request do
  let!(:advertiser) {FactoryBot.create(:advertisers)}

  authorization = ActionController::HttpAuthentication::Basic.encode_credentials('admin123','admin123')
  before {get "/api/v1/admin/advertisers/#{advertiser.id}", headers: { 'HTTP_AUTHORIZATION' => authorization }}

  it 'return the advertiser' do
    subject = JSON.parse(response.body)

    expect(subject["data"]["name"]).to eq(advertiser.name)
    expect(subject["data"]["url"]).to eq(advertiser.url)
  end

  it 'return status code 200' do
    expect(response).to have_http_status(:success)
  end
end
