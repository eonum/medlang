Rails.application.routes.draw do

  resources :users
  scope '/:locale', :locale => /de|fr|it|en/, :format => /json|html/ do
    resources :words

    resources :categories

    resources :users



  end

  root :to => 'infos#home'
end
