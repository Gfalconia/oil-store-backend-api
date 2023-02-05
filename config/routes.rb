Rails.application.routes.draw do
  resources :products
  options 'products', to: 'products#options'
  options 'products/:id', to: 'products#options'
  options 'products/upload_image/:id', to: 'products#options'
  post 'products/upload_image/:id', to: 'products#upload'
  get 'product_image/:id', to: 'products#show'
end
