require 'rails_helper'

describe "post a advertiser route", :type => :request do

  describe 'Success' do
    before do
      post '/api/v1/admin/advertisers', params: {:name => 'Walmart', :url => 'https://wallmart.com'}
    end

    it 'returns the advertiser' do
      subject = JSON.parse(response.body)
      expect(subject["data"]["name"]).to eq('Walmart')
      expect(subject["data"]["url"]).to eq('https://wallmart.com')
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Fail' do
    describe 'Url not valid' do
      before do
        post '/api/v1/admin/advertisers', params: {:name => 'Walmart', :url => 'https://wallmart@com'}
      end

      it 'returns the advertiser' do
        subject = JSON.parse(response.body)
        expect(subject["data"]).to eq("url"=>["is invalid"])
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    describe 'Advertiser already exist' do
      before do
        Advertiser.create(name: 'Walmart', url: 'https://wallmart.com')
        post '/api/v1/admin/advertisers', params: {:name => 'Walmart', :url => 'https://wallmart.com'}
      end

      it 'returns the advertiser' do
        subject = JSON.parse(response.body)
        expect(subject["data"]).to eq("name"=>["has already been taken"])
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
