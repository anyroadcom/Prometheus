Rails.application.routes.draw do
  namespace :api do
    resources :guides, only: [:index, :show, :create]
    post '/get_image' => 'guides#get_image'
  end

  match '*path', to: 'errors#not_found', via: :all
end
