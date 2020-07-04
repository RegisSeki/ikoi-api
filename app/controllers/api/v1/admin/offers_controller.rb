module Api
  module V1
    module Admin
      class OffersController < ApplicationController
        def show
        end

        def create
          offer = Offer.new(offer_params)
          if offer.save
            offers = Offer.by_advertiser_id(offer.advertiser_id)
            render json: {status: 'SUCCESS', message:"Offer Saved! Following all other offers from #{offer.advertiser.name}", data:offers},status: :ok
          else
            render json: {status: 'ERROR', message:'Offer not saved', data:offer.errors},status: :unprocessable_entity
          end
        end

        def update
          offer = Offer.find(params[:id])
          if offer.update(offer_params)
            render json: {status: 'SUCCESS', message:'Offer Updated', data:offer},status: :ok
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
