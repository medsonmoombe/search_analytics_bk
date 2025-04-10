Rails.application.routes.draw do
  namespace :api do
    post 'search/track', to: 'search#track'
    get 'search/analytics', to: 'search#analytics'
  end
end

