Rails.application.routes.draw do

  scope '/:locale', :locale => /de|fr|it|en/, :format => /json|html/ do
    resources :words

    resources :categories


  end

  root :to => 'infos#home'
end
