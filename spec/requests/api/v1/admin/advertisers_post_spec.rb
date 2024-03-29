require 'rails_helper'

describe "post advertiser route", :type => :request do
  before(:each) do
    @authorization = ActionController::HttpAuthentication::Basic.encode_credentials('admin123','admin123')
  end

  describe 'Success' do
    describe 'when all the parameters are correct' do
      before do
        post '/api/v1/admin/advertisers', params: {:name => 'Walmart', :url => 'https://wallmart.com'}, headers: { 'HTTP_AUTHORIZATION' => @authorization }
      end

      it 'return the advertiser' do
        subject = JSON.parse(response.body)
        expect(subject["data"]["name"]).to eq('Walmart')
        expect(subject["data"]["url"]).to eq('https://wallmart.com')
      end

      it 'return status code 200' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'Fail' do
    describe 'when url parameter is not valid' do
      before do
        post '/api/v1/admin/advertisers', params: {:name => 'Walmart', :url => 'https://wallmart@com'}, headers: { 'HTTP_AUTHORIZATION' => @authorization }
      end

      it 'return error' do
        subject = JSON.parse(response.body)
        expect(subject["data"]).to eq("url"=>["is invalid"])
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    describe 'when without needed params' do
      before do
        post '/api/v1/admin/advertisers', headers: { 'HTTP_AUTHORIZATION' => @authorization }
      end

      it 'return error' do
        subject = JSON.parse(response.body)
        expect(subject["data"]).to eq("name"=>["can't be blank"], "url"=>["can't be blank", "is invalid"])
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    describe 'when advertiser already exist' do
      before do
        Advertiser.create(name: 'Walmart', url: 'https://wallmart.com')
        post '/api/v1/admin/advertisers', params: {:name => 'Walmart', :url => 'https://wallmart.com'}, headers: { 'HTTP_AUTHORIZATION' => @authorization }
      end

      it 'return error' do
        subject = JSON.parse(response.body)
        expect(subject["data"]).to eq("name"=>["has already been taken"])
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
