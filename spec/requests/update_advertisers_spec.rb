require 'rails_helper'

describe "PUT a advertiser route", :type => :request do

  describe 'Success' do
    let!(:advertiser) {FactoryBot.create(:advertisers)}

    before do
      put "/api/v1/admin/advertisers/#{advertiser.id}", params: {:name => 'Walmart', :url => 'https://wallmart.com'}
    end

    it 'returns the advertiser updated' do
      subject = JSON.parse(response.body)
      expect(subject["data"]["name"]).to eq('Walmart')
      expect(subject["data"]["url"]).to eq('https://wallmart.com')
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Fail' do
    before do
      Advertiser.create(name: 'Walmart', url: 'https://walmart.com')
      @trying_update_advertiser = Advertiser.create(name: 'Carrefour', url: 'https://carrefour.com')
    end

    describe 'Url not valid' do
      before do
        put "/api/v1/admin/advertisers/#{@trying_update_advertiser.id}", params: {:name => 'Carrefour', :url => 'https://carrefour@com?@'}
      end

      it 'returns error' do
        subject = JSON.parse(response.body)
        expect(subject["data"]).to eq("url"=>["is invalid"])
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    describe 'Advertiser name already exist' do
      before do
        put "/api/v1/admin/advertisers/#{@trying_update_advertiser.id}", params: {:name => 'Walmart', :url => 'https://walmart.com'}
      end

      it 'returns error' do
        subject = JSON.parse(response.body)
        expect(subject["data"]).to eq("name"=>["has already been taken"])
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
