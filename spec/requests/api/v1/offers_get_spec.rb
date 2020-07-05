require 'rails_helper'

describe "get users list offers route", :type => :request do
  before(:each) do
    @authorization = ActionController::HttpAuthentication::Basic.encode_credentials('admin123','admin123')
  end

  let!(:advertiser) {FactoryBot.create(:advertisers)}

  describe 'show offer have already started' do
    before do
      already_start_time = Time.now - 1.day
      future_time = Time.now + 1.day
      @enabled_offer = Offer.create(advertiser_id: advertiser.id, url: 'https://enabled.com', description: 'Enabled', starts_at: already_start_time)
      Offer.create(advertiser_id: advertiser.id, url: 'https://disabled.com', description: 'Disabled', starts_at: future_time)

      get '/api/v1/offers', headers: { 'HTTP_AUTHORIZATION' => @authorization }
    end

    it 'return only enabled offer' do
      subject = JSON.parse(response.body)

      expect(subject["data"].size).to eq(1)
      expect(subject["data"].first["description"]).to eq(@enabled_offer.description)
      expect(subject["data"].first["url"]).to eq(@enabled_offer.url)
    end

    it 'return status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'not show offers that already finished' do
    before do
      past_time = Time.now - 1.day
      Offer.create(advertiser_id: advertiser.id, url: 'https://walmart.com', description: 'Any', starts_at: Time.now, ends_at: past_time)
      @enabled_offer = Offer.create(advertiser_id: advertiser.id, url: 'https://enabled.com', description: 'enabled', starts_at: Time.now)

      get '/api/v1/offers', headers: { 'HTTP_AUTHORIZATION' => @authorization }
    end

    it 'return only starts_at with past_time' do
      subject = JSON.parse(response.body)

      expect(subject["data"].size).to eq(1)
      expect(subject["data"].first["description"]).to eq(@enabled_offer.description)
      expect(subject["data"].first["url"]).to eq(@enabled_offer.url)
    end

    it 'return status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'show offers with premium true first' do
    before do
      @first_premium = Offer.create(advertiser_id: advertiser.id, url: 'https://premium.com', description: 'First', starts_at: Time.now, premium: true)
      @second_premium = Offer.create(advertiser_id: advertiser.id, url: 'https://premium.com', description: 'Second', starts_at: Time.now, premium: true)
      @not_premium = Offer.create(advertiser_id: advertiser.id, url: 'https://not-premium.com', description: 'not-premium', starts_at: Time.now)

      get '/api/v1/offers', headers: { 'HTTP_AUTHORIZATION' => @authorization }
    end

    it 'return the premium offers first' do
      subject = JSON.parse(response.body)

      expect(subject["data"].size).to eq(3)
      expect(subject["data"][0]["description"]).to eq(@first_premium.description)
      expect(subject["data"][1]["description"]).to eq(@second_premium.description)
      expect(subject["data"][2]["description"]).to eq(@not_premium.description)
    end

    it 'return status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end
