require 'rails_helper'

describe "post an offer route", :type => :request do
  let!(:advertiser) {FactoryBot.create(:advertisers)}

  describe 'Success' do
    before do
      Offer.create(advertiser_id: advertiser.id, url: 'https://walmart.com/owesome-sale', description: 'Owesome sale', starts_at: '2020-07-03 20:30:00')

      post '/api/v1/admin/offers', params:
      {
        :advertiser_id => "#{advertiser.id}",
        :url => "https://walmart.com/owesome-sale-2",
        :description => "Freak owesome sale",
        :starts_at => "2020-07-03 20:30:00",
        :ends_at => "2020-07-13 20:30:00"
      }
    end

    it 'return current offer and all others offers of this advertiser' do
      subject = JSON.parse(response.body)
      expect(subject["data"].size).to eq 2
    end

    it 'return status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Fail' do
    describe 'Url not valid' do
      before do
        post '/api/v1/admin/offers', params:
          {
            :advertiser_id => "#{advertiser.id}",
            :url => "https://walmart.com/owesome-sale-2@@ @@",
            :description => "Freak owesome sale",
            :starts_at => "2020-07-03 20:30:00",
            :ends_at => "2020-07-13 20:30:00"
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

    describe 'description too big' do
      before do
        post '/api/v1/admin/offers', params:
          {
            :advertiser_id => "#{advertiser.id}",
            :url => "https://walmart.com/owesome",
            :description => "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In rhoncus neque eget fringilla efficitur. Aenean felis odio, commodo at accumsan egestas, fringilla eget dui. Vivamus laoreet velit quis volutpat tristique. Ut congue arcu in elit dignissim fermentum. Ut luctus orci condimentum, hendrerit massa eget, blandit nisi. Quisque varius mi venenatis vestibulum vehicula. Curabitur et velit vel ante tincidunt egestas. Aliquam porttitor gravida mi, sit amet ullamcorper dui bibendum et. Suspendisse elit sapien.",
            :starts_at => "2020-07-03 20:30:00",
            :ends_at => "2020-07-13 20:30:00"
          }
      end

      it 'return error' do
        subject = JSON.parse(response.body)
        expect(subject["data"]).to eq("description" => ["is too long (maximum is 500 characters)"])
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    describe 'without starts_at' do
      before do
        post '/api/v1/admin/offers', params:
          {
            :advertiser_id => "#{advertiser.id}",
            :url => "https://walmart.com/owesome",
            :description => "Ut congue arcu in elit dignissim fermentum.",
            :starts_at => "",
            :ends_at => "2020-07-13 20:30:00"
          }
      end

      it 'return error' do
        subject = JSON.parse(response.body)
        expect(subject["data"]).to eq("starts_at"=>["can't be blank"])
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    describe 'with wrong advertiser_id' do
      before do
        post '/api/v1/admin/offers', params:
          {
            :advertiser_id => "",
            :url => "https://walmart.com/owesome",
            :description => "Ut congue arcu in elit dignissim fermentum.",
            :starts_at => "2020-07-13 20:30:00",
            :ends_at => "2020-07-13 20:30:00"
          }
      end

      it 'return error' do
        subject = JSON.parse(response.body)
        expect(subject["data"]).to eq("advertiser" => ["must exist"])
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
