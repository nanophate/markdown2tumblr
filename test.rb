require 'tumblr_client'
#require 'pry'

  Tumblr.configure do |config|
    config.consumer_key = ENV['TUMBLR_CONSUMER_KEY']
    config.consumer_secret = ENV['TUMBLR_CONSUMER_SECRET']
    config.oauth_token = ENV['TUMBLR_OAUTH_TOKEN']
    config.oauth_token_secret = ENV['TUMBLR_OAUTH_TOKEN_SECRET']
  end

  client = Tumblr::Client.new 

  puts client.info['user']['name']
  
=begin
  [1] pry(main)> client.info
=> {"user"=>
  {"name"=>"nanophate",
   "likes"=>4,
   "following"=>5,
   "default_post_format"=>"html",
   "blogs"=>
    [{"title"=>"Digital Fab & Design",
      "name"=>"nanophate",
      "total_posts"=>10,
      "posts"=>10,
      "url"=>"http://nanophate.tumblr.com/",
      "updated"=>146-------,
      "description"=>"Place where I randomly talk about my idea. Topics from Digital Fabriacation (Tech) to Work Flow management (Design).",
      "is_nsfw"=>false,
      "ask"=>false,
      "ask_page_title"=>"Ask me anything",
      "ask_anon"=>false,
      "followed"=>false,
      "can_send_fan_mail"=>true,
      "is_blocked_from_primary"=>false,
      "share_likes"=>true,
      "likes"=>4,
      "twitter_enabled"=>true,
      "twitter_send"=>false,
      "facebook_opengraph_enabled"=>"N",
      "tweet"=>"Y",
      "facebook"=>"N",
      "followers"=>2,
      "primary"=>true,
      "admin"=>true,
      "messages"=>0,
      "queue"=>0,
      "drafts"=>0,
      "type"=>"public",
      "reply_conditions"=>2,
      "subscribed"=>false,
      "can_subscribe"=>false}]}} 		
=end
