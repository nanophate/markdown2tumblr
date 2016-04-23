require 'rubygems'
require 'sinatra'
require 'json'
require 'tumblr_client'
require 'omniauth'
require 'omniauth-tumblr'

class SinatraApp < Sinatra::Base
  configure do
    set :sessions, true
    set :inline_templates, true
  end

  use OmniAuth::Builder do
    provider :tumblr, ENV['TUMBLR_CONSUMER_KEY'], ENV['TUMBLR_CONSUMER_SECRET']
  end

get "/" do
  if session[:authenticated]
    erb :index
  else
  	erb :signin
  end
end

get "/auth/:provider/callback" do
  session[:authenticated] = true
  
  auth = request.env["omniauth.auth"]
  session[:user_id] = auth["uid"]
  session[:access_token] = auth['credentials']['token']
  session[:access_token_secret] = auth['credentials']['secret']
  
  Tumblr.configure do |config|
	config.consumer_key = ENV['TUMBLR_CONSUMER_KEY']
	config.consumer_secret = ENV['TUMBLR_CONSUMER_SECRET']
	config.oauth_token = session[:access_token]
	config.oauth_token_secret = session[:access_token_secret]
  end
  @@client = Tumblr::Client.new
  redirect '/'
end

post '/' do
  begin
    @@client.text("nanophate.tumblr.com",{:title => 'test', :body => 'Life is just a mere dream'})
  end
end

get '/auth/failure' do
  "<h1>Authentication Failed:</h1><h3>message:<h3> <pre>#{params}</pre>"
end

get '/auth/:provider/deauthorized' do
  "#{params[:provider]} has deauthorized this app."
end

get '/protected' do
  throw(:halt, [401, "Not authorized\n"]) unless session[:authenticated]
  "<pre>#{request.env['omniauth.auth'].to_json}</pre><hr>
    <a href='/logout'>Logout</a>"
end

get '/logout' do
  session[:authenticated] = false
  redirect '/'
end

not_found do
  status 404
  "not found"
end

end