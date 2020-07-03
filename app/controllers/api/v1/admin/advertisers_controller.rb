module Api
  module V1
    module Admin
      class AdvertisersController < ApplicationController
        def index
          advertisers = Advertiser.all
          render json: {status: 'SUCCESS', message: 'List of advertisers', data:advertisers}, status: :ok
        end

        def show
          advertiser = Advertiser.find(params[:id])
          render json: {status: 'SUCCESS', message: '', data: advertiser}, status: :ok
        end

        def create
          advertiser = Advertiser.new(advertiser_params)
          if advertiser.save
            render json: {status: 'SUCCESS', message:'Saved advertiser', data:advertiser},status: :ok
          else
            render json: {status: 'ERROR', message:'Advertiser not saved', data:advertiser.errors},status: :unprocessable_entity
          end
        end

        def update
          advertiser = Advertiser.find(params[:id])
          if advertiser.update(advertiser_params)
            render json: {status: 'SUCCESS', message:'Updated advertiser', data:advertiser},status: :ok
          else
            render json: {status: 'ERROR', message:'Advertiser not update', data:advertiser.errors},status: :unprocessable_entity
          end
        end

        private
        def advertiser_params
          params.permit(:name, :url)
        end
      end
    end
  end
end
