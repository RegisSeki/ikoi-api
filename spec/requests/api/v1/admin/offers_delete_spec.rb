require 'rails_helper'

describe "delete offer route", :type => :request do
  let!(:offers) {FactoryBot.create(:offers)}

  describe 'successully deleted' do
    before do
      delete "/api/v1/admin/offers/#{offers.id}", params: {}
    end

    it 'return deleted offer' do
      subject = JSON.parse(response.body)
      expect(subject["message"]).to eq 'Offer deleted'
      expect(Offer.all).to be_empty
    end

    it 'return status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end
