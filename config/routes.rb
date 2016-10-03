# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      resource :treasure_hunt, only: %i(create)
      resources :analytics, only: %i(index)
    end
  end
end
