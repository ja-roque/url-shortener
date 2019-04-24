Rails.application.routes.draw do

  get  '/top.json' => 'url_checker#top100',  as: :top_100_urls
  post '/url.json' => 'url_checker#create_short_url', as: :create_short_url
  get  '/:short_hash' => 'url_checker#redirect_to_short_url',  as: :redirect_to_short_url

end
