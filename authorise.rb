require 'rubygems'
require 'oauth'
require 'net/http'
require 'json'
require 'date'
require 'yaml'

module Authorise
  def self.oapi_authorise(consumer_key, consumer_secret, site, username=nil, password=nil)

    @consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {
      :site => site,
        :http_method => :get,
        :request_token_path => "/oauth/request_token/",
        :access_token_path => "/oauth/access_token/",
        :authorize_path => "/oauth/authorize"
        })

    @request_token = @consumer.get_request_token

    verifier = Authorise.get_verifier(username, password)

    puts "Converting request token into access token"
    @access_token=@request_token.get_access_token(:oauth_verifier => verifier)

    auth = {access_token: @access_token}

    File.open('auth.yaml', 'w') {|f| YAML.dump(auth, f)}

    puts "Done. The auth.yaml file should have all it needs"
    return @access_token
  end

  def self.get_verifier(username=nil, password=nil)
    if username && password
      verifier = Browser.login_get_verifier(username, password, @request_token.authorize_url)
    else     
      puts "Go there, doofus: "
      puts @request_token.authorize_url
      puts "Put the thing here: "
      verifier = gets.chomp
    end
  end 
end







