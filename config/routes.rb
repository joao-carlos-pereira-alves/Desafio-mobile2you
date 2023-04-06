# frozen_string_literal: true

Rails.application.routes.draw do
  constraints subdomain: /.*/ do
    namespace :api do
      namespace :v1 do
        defaults format: :json do
          # resources :rota
        end
      end
    end
  end
end
