Refinery::Application.routes.draw do
  resources :features

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :features do
      collection do
        post :update_positions
      end
    end
  end
end
