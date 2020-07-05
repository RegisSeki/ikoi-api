include ActionController::HttpAuthentication::Basic::ControllerMethods

module Api
  module V1
    module Admin
      class AdvertisersController < ApplicationController
        http_basic_authenticate_with name: ENV['ADMIN_KEY'], password: ENV['ADMIN_SECRET'], except: :index
        def index
          advertisers = Advertiser.all
          render json: {status: 'SUCCESS', message: 'List of all advertisers', data:advertisers}, status: :ok
        end

        def show
          advertiser = Advertiser.find(params[:id])
          render json: {status: 'SUCCESS', message: 'Advertiser', data: advertiser}, status: :ok
        end

        def create
          advertiser = Advertiser.new(advertiser_params)
          if advertiser.save
            render json: {status: 'SUCCESS', message:'Advertiser created', data:advertiser},status: :ok
          else
            render json: {status: 'ERROR', message:'Advertiser not created', data:advertiser.errors},status: :unprocessable_entity
          end
        end

        def update
          advertiser = Advertiser.find(params[:id])
          if advertiser.update(advertiser_params)
            render json: {status: 'SUCCESS', message:'Advertiser updated', data:advertiser},status: :ok
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
