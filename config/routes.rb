Rails.application.routes.draw do

  resources :words

  resources :categories
  scope '/:locale', :locale => /de|fr|it|en/, :format => /json|html/ do
  end

  root :to => 'infos#home'
end
