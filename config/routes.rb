Rails.application.routes.draw do


  namespace :api, constraints: { format: :json } do

    namespace :v1 do
      resources :sample, only: :index
    end

  end

end
