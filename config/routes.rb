Rails.application.routes.draw do
  resources :subscribers
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
  
  root 'home#index'
   
end