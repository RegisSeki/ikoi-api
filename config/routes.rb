Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      namespace 'admin' do
        resources :advertisers, only: [:index, :show, :create, :update]
        resources :offers, only: [:create, :update, :destroy]
      end
      resources :offers, only: [:index]
    end
  end
end
