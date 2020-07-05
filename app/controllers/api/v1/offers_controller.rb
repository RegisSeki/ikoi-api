module Api
  module V1
    class OffersController < ApplicationController
      http_basic_authenticate_with name: ENV['ADMIN_KEY'], password: ENV['ADMIN_SECRET']

      def index
        offers = Offer.enabled_offers
        render json: {status: 'SUCCESS', message:'Offers list', data:offers},status: :ok
      end
    end
  end
end
