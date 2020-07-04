require 'rails_helper'
require "ostruct"

describe "put an offer route", :type => :request do
  let!(:offers) {FactoryBot.create(:offers)}

  describe 'Success' do
    describe 'when all parameters are corrects' do
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
        }
      end

      it 'return updated offer with the same values at parameters' do
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
  end

  describe 'Fail' do
    describe 'Url no valid' do
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
        }
      end

      it 'return error' do
        subject = JSON.parse(response.body)
        expect(subject["data"]).to eq("url"=>["is invalid"])
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # describe 'Fail' do
  #   describe 'Url not valid' do
  #     before do
  #       post '/api/v1/admin/offers', params:
  #         {
  #           :advertiser_id => "#{advertiser.id}",
  #           :url => "https://walmart.com/owesome-sale-2@@ @@",
  #           :description => "Freak owesome sale",
  #           :starts_at => "2020-07-03 20:30:00",
  #           :ends_at => "2020-07-13 20:30:00"
  #         }
  #     end

  #     it 'return error' do
  #       subject = JSON.parse(response.body)
  #       expect(subject["data"]).to eq("url"=>["is invalid"])
  #     end

  #     it 'return status code 422' do
  #       expect(response).to have_http_status(422)
  #     end
  #   end

  #   describe 'description too big' do
  #     before do
  #       post '/api/v1/admin/offers', params:
  #         {
  #           :advertiser_id => "#{advertiser.id}",
  #           :url => "https://walmart.com/owesome",
  #           :description => "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In rhoncus neque eget fringilla efficitur. Aenean felis odio, commodo at accumsan egestas, fringilla eget dui. Vivamus laoreet velit quis volutpat tristique. Ut congue arcu in elit dignissim fermentum. Ut luctus orci condimentum, hendrerit massa eget, blandit nisi. Quisque varius mi venenatis vestibulum vehicula. Curabitur et velit vel ante tincidunt egestas. Aliquam porttitor gravida mi, sit amet ullamcorper dui bibendum et. Suspendisse elit sapien.",
  #           :starts_at => "2020-07-03 20:30:00",
  #           :ends_at => "2020-07-13 20:30:00"
  #         }
  #     end

  #     it 'return error' do
  #       subject = JSON.parse(response.body)
  #       expect(subject["data"]).to eq("description" => ["is too long (maximum is 500 characters)"])
  #     end

  #     it 'return status code 422' do
  #       expect(response).to have_http_status(422)
  #     end
  #   end

  #   describe 'without starts_at' do
  #     before do
  #       post '/api/v1/admin/offers', params:
  #         {
  #           :advertiser_id => "#{advertiser.id}",
  #           :url => "https://walmart.com/owesome",
  #           :description => "Ut congue arcu in elit dignissim fermentum.",
  #           :starts_at => "",
  #           :ends_at => "2020-07-13 20:30:00"
  #         }
  #     end

  #     it 'return error' do
  #       subject = JSON.parse(response.body)
  #       expect(subject["data"]).to eq("starts_at"=>["can't be blank"])
  #     end

  #     it 'return status code 422' do
  #       expect(response).to have_http_status(422)
  #     end
  #   end

  #   describe 'with wrong advertiser_id' do
  #     before do
  #       post '/api/v1/admin/offers', params:
  #         {
  #           :advertiser_id => "",
  #           :url => "https://walmart.com/owesome",
  #           :description => "Ut congue arcu in elit dignissim fermentum.",
  #           :starts_at => "2020-07-13 20:30:00",
  #           :ends_at => "2020-07-13 20:30:00"
  #         }
  #     end

  #     it 'return error' do
  #       subject = JSON.parse(response.body)
  #       expect(subject["data"]).to eq("advertiser" => ["must exist"])
  #     end

  #     it 'return status code 422' do
  #       expect(response).to have_http_status(422)
  #     end
  #   end
  # end
end
