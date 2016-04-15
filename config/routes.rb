Rails.application.routes.draw do

  scope '/:locale', :locale => /de|fr|it|en/, :format => /json|html/ do
    resources :words
  end
  root :to => 'words#index'
end
