class ApplicationController < ActionController::API
  unless Rails.env.production?
    ENV['ADMIN_KEY'] = 'admin123'
    ENV['ADMIN_SECRET'] = 'admin123'
  end
end
