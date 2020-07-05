module Api
  module V1
    class OffersController < ApplicationController
      def index
        offers = Offer.enabled_offers
        render json: {status: 'SUCCESS', message:'Offers list', data:offers},status: :ok
      end
    end
  end
end
