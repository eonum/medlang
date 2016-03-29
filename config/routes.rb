Rails.application.routes.draw do

  scope '/:locale', :locale => /de|fr|it|en/, :format => /json|html/ do

  end
end
