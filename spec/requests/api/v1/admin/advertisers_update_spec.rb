require 'rails_helper'

describe "put advertiser route", :type => :request do
  before(:each) do
    @authorization = ActionController::HttpAuthentication::Basic.encode_credentials('admin123','admin123')
  end

  describe 'Success' do
    let!(:advertiser) {FactoryBot.create(:advertisers)}

    describe 'when all parameters are correct' do

      before do
        put "/api/v1/admin/advertisers/#{advertiser.id}", params: {:name => 'Walmart', :url => 'https://wallmart.com'}, headers: { 'HTTP_AUTHORIZATION' => @authorization }
      end

      it 'return the advertiser updated' do
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
    before do
      Advertiser.create(name: 'Walmart', url: 'https://walmart.com')
      @trying_update_advertiser = Advertiser.create(name: 'Carrefour', url: 'https://carrefour.com')
    end

    describe 'when url not valid' do
      before do
        put "/api/v1/admin/advertisers/#{@trying_update_advertiser.id}", params: {:name => 'Carrefour', :url => 'https://carrefour@com?@'}, headers: { 'HTTP_AUTHORIZATION' => @authorization }
      end

      it 'return error' do
        subject = JSON.parse(response.body)
        expect(subject["data"]).to eq("url"=>["is invalid"])
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    describe 'when advertiser name already exist' do
      before do
        put "/api/v1/admin/advertisers/#{@trying_update_advertiser.id}", params: {:name => 'Walmart', :url => 'https://walmart.com'}, headers: { 'HTTP_AUTHORIZATION' => @authorization }
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
