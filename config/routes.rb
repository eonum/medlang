Rails.application.routes.draw do

  scope '/:locale', :locale => /de|fr|it|en/, :format => /json|html|csv/ do

    resources :words
    get 'export', to: 'words#export', as: :words_export

    resources :categories

    resources :users

    resources :learn_sessions
  end

  root :to => 'infos#home'
end
