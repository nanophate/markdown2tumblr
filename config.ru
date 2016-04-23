require 'sinatra'
require 'tumblr_client'
require 'omniauth-tumblr'
load  'app.rb'

use OmniAuth::Builder do
  provider :tumblr, ENV['TUMBLR_CONSUMER_KEY'], ENV['TUMBLR_CONSUMER_SECRET']
end

run Sinatra::Application