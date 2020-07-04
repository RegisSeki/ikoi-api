require 'rails_helper'

describe "get all advertisers route", :type => :request do
  let!(:advertisers) {FactoryBot.create_list(:advertisers, 5)}

  before {get '/api/v1/admin/advertisers'}

  it 'returns all advertisers' do
    subject = JSON.parse(response.body)

    expect(subject["data"].size).to eq(5)
    expect(subject["data"][0]["name"]).not_to be_empty
    expect(subject["data"][0]["url"]).not_to be_empty
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end
