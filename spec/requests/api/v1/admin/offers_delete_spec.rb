require 'rails_helper'

describe "delete offer route", :type => :request do
  let!(:offers) {FactoryBot.create(:offers)}

  describe 'successully deleted' do
    before do
      authorization = ActionController::HttpAuthentication::Basic.encode_credentials('admin123','admin123')
      delete "/api/v1/admin/offers/#{offers.id}", headers: { 'HTTP_AUTHORIZATION' => authorization }
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
