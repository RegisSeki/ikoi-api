require 'rails_helper'
require "ostruct"

describe "put offer route", :type => :request do
  before(:each) do
    @authorization = ActionController::HttpAuthentication::Basic.encode_credentials('admin123','admin123')
  end

  let!(:offers) {FactoryBot.create(:offers)}

  describe 'Success' do
    describe 'when all parameters are correct' do
      before do
        @params = OpenStruct.new
        @params.advertiser_id = offers.advertiser.id
        @params.url = 'https://walmart.com/owesome-sale-2'
        @params.description = 'Freak owesome sale'
        @params.starts_at = '2020-07-03T20:30:00.000Z'
        @params.ends_at = '2020-07-03T20:30:00.000Z'

        put "/api/v1/admin/offers/#{offers.id}", params:
        {
          :advertiser_id => @params.advertiser_id,
          :url => @params.url,
          :description => @params.description,
          :starts_at => @params.starts_at,
          :ends_at => @params.ends_at
        }, headers: { 'HTTP_AUTHORIZATION' => @authorization }
      end

      it 'return updated offer with the same values of parameters' do
        subject = JSON.parse(response.body)

        expect(subject["data"]["advertiser_id"]).to eq @params.advertiser_id
        expect(subject["data"]["url"]).to eq @params.url
        expect(subject["data"]["description"]).to eq @params.description
        expect(subject["data"]["starts_at"]).to eq @params.starts_at
        expect(subject["data"]["ends_at"]).to eq @params.ends_at
        expect(subject["data"]["premium"]).to eq false
      end

      it 'return status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    describe 'when admin wants to enable an offer' do
      before do
        put "/api/v1/admin/offers/#{offers.id}", params:
        {
          :starts_at => '2020-07-05 00:19:41',
          :ends_at => ''
        }, headers: { 'HTTP_AUTHORIZATION' => @authorization }
      end

      it 'return updated offer with the same values at parameters' do
        subject = JSON.parse(response.body)

        expect(subject["data"]["starts_at"]).to eq '2020-07-05T00:19:41.000Z'
        expect(subject["data"]["ends_at"]).to eq nil
      end

      it 'return status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    describe 'when admin wants to disable an offer' do
      before do
        put "/api/v1/admin/offers/#{offers.id}", params:
        {
          :ends_at => '2020-07-05 00:19:41'
        }, headers: { 'HTTP_AUTHORIZATION' => @authorization }
      end

      it 'return offer with the ends_date updated' do
        subject = JSON.parse(response.body)

        expect(subject["data"]["ends_at"]).to eq '2020-07-05T00:19:41.000Z'
      end

      it 'return status code 200' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'Fail' do
    describe 'when wrong advertiser id parameter' do
      before do
        @params = OpenStruct.new
        @params.advertiser_id = ""
        @params.url = 'https://walmart.com/owesome-sale-2'
        @params.description = 'Freak owesome sale'
        @params.starts_at = '2020-07-03T20:30:00.000Z'
        @params.ends_at = '2020-07-03T20:30:00.000Z'

        put "/api/v1/admin/offers/#{offers.id}", params:
        {
          :advertiser_id => @params.advertiser_id,
          :url => @params.url,
          :description => @params.description,
          :starts_at => @params.starts_at,
          :ends_at => @params.ends_at
        }, headers: { 'HTTP_AUTHORIZATION' => @authorization }
      end

      it 'return error' do
        subject = JSON.parse(response.body)
        expect(subject["data"]).to eq("advertiser" => ["must exist"])
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    describe 'when url parameter is not valid' do
      before do
        @params = OpenStruct.new
        @params.advertiser_id = offers.advertiser.id
        @params.url = 'https://walmart.com/owesome-sale-2 / /@#'
        @params.description = 'Freak owesome sale'
        @params.starts_at = '2020-07-03T20:30:00.000Z'
        @params.ends_at = '2020-07-03T20:30:00.000Z'

        put "/api/v1/admin/offers/#{offers.id}", params:
        {
          :advertiser_id => @params.advertiser_id,
          :url => @params.url,
          :description => @params.description,
          :starts_at => @params.starts_at,
          :ends_at => @params.ends_at
        }, headers: { 'HTTP_AUTHORIZATION' => @authorization }
      end

      it 'return error' do
        subject = JSON.parse(response.body)
        expect(subject["data"]).to eq("url"=>["is invalid"])
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    describe 'when description parameter is greater than 500 characters advertiser id' do
      before do
        @params = OpenStruct.new
        @params.advertiser_id = offers.advertiser.id
        @params.url = 'https://walmart.com/owesome-sale-2'
        @params.description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In rhoncus neque eget fringilla efficitur. Aenean felis odio, commodo at accumsan egestas, fringilla eget dui. Vivamus laoreet velit quis volutpat tristique. Ut congue arcu in elit dignissim fermentum. Ut luctus orci condimentum, hendrerit massa eget, blandit nisi. Quisque varius mi venenatis vestibulum vehicula. Curabitur et velit vel ante tincidunt egestas. Aliquam porttitor gravida mi, sit amet ullamcorper dui bibendum et. Suspendisse elit sapien.'
        @params.starts_at = '2020-07-03T20:30:00.000Z'
        @params.ends_at = '2020-07-03T20:30:00.000Z'

        put "/api/v1/admin/offers/#{offers.id}", params:
        {
          :advertiser_id => @params.advertiser_id,
          :url => @params.url,
          :description => @params.description,
          :starts_at => @params.starts_at,
          :ends_at => @params.ends_at
        }, headers: { 'HTTP_AUTHORIZATION' => @authorization }
      end

      it 'return error' do
        subject = JSON.parse(response.body)
        expect(subject["data"]).to eq("description" => ["is too long (maximum is 500 characters)"])
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    describe 'without starts_at parameter' do
      before do
        @params = OpenStruct.new
        @params.advertiser_id = offers.advertiser.id
        @params.url = 'https://walmart.com/owesome-sale-2'
        @params.description = 'Lorem ipsum dolor sit amet'
        @params.starts_at = ''
        @params.ends_at = '2020-07-03T20:30:00.000Z'

        put "/api/v1/admin/offers/#{offers.id}", params:
        {
          :advertiser_id => @params.advertiser_id,
          :url => @params.url,
          :description => @params.description,
          :starts_at => @params.starts_at,
          :ends_at => @params.ends_at
        }, headers: { 'HTTP_AUTHORIZATION' => @authorization }
      end

      it 'return error' do
        subject = JSON.parse(response.body)
        expect(subject["data"]).to eq("starts_at" => ["can't be blank"])
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
