include ActionController::HttpAuthentication::Basic::ControllerMethods

module Api
  module V1
    module Admin
      class OffersController < ApplicationController
        http_basic_authenticate_with name: ENV['ADMIN_KEY'], password: ENV['ADMIN_SECRET']

        def index
          offers = Offer.all
          render json: {status: 'SUCCESS', message: 'All offers', data:offers}, status: :ok
        end

        def create
          offer = Offer.new(offer_params)
          if offer.save
            render json: {status: 'SUCCESS', message:"Offer created!", data:Offer.order_by_desc},status: :ok
          else
            render json: {status: 'ERROR', message:'Offer not created', data:offer.errors},status: :unprocessable_entity
          end
        end

        def update
          offer = Offer.find(params[:id])
          if offer.update(offer_params)
            render json: {status: 'SUCCESS', message:'Offer updated', data:offer},status: :ok
          else
            render json: {status: 'ERROR', message:'Offer not updated', data:offer.errors},status: :unprocessable_entity
          end
        end

        def destroy
          offer = Offer.find(params[:id])
          offer.destroy
          render json: {status: 'SUCCESS', message:'Offer deleted', data:offer},status: :ok
        end

        private
        def offer_params
          params.permit(:advertiser_id, :url, :description, :starts_at, :ends_at, :premium)
        end
      end
    end
  end
end
