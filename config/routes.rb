Rails.application.routes.draw do
   root 'home#top'
  get "/search_premium" => "home#search_premium"
  get "/search_standerd" =>"home#search_standerd"
  get "/read" =>"home#read"
  post "/import" => "home#import"
  post "/download" =>"home#download"
end
