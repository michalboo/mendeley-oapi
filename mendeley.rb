require 'rubygems'
require 'yaml'
require 'uri'
require 'oauth'
require 'digest/sha1'

class Mendeley
  require File.dirname(__FILE__) + '/public_methods.rb'
  require File.dirname(__FILE__) + '/private_methods.rb'
  require File.dirname(__FILE__) + '/authorise.rb'
  require File.dirname(__FILE__) + '/browser.rb'

  include Public_methods
  include Private_methods
  include Authorise
  include Browser

  config = YAML::load(File.open("config.yaml"))
  $default_key = config[:default_key]
  $default_secret = config[:default_secret]
  $default_site = config[:default_site]

  def initialize(username=nil, password=nil, consumer_key=$default_key, consumer_secret=$default_secret, site=$default_site)

    if File.exist?("auth.yaml") && ((username && password) == nil)
      auth_contents = YAML::load(File.open("auth.yaml"))
      $access_token = auth_contents[:access_token]
    end
    $access_token = Authorise.oapi_authorise(consumer_key, consumer_secret, site, username, password) if $access_token == nil
    puts $access_token
  end

  def get_response(method_url, options=nil)
    @token = $access_token
    req = create_request_url(method_url, options)
    puts "Sending get request to: #{req}"
    response = @token.get(req)
    if response.code == "302"
      #TODO properly handle the download redirections
      response = Net::HTTP.get(URI(response.header['location']))
    end
    return response
  end

  def post_response(method_url, body=nil)
    @token = $access_token    
    response = @token.post(method_url, body)
  end

  def put_response(method_url, name, body, sha1)
    @token = $access_token
    response = @token.put(method_url, body, { "sha1_hash" => sha1, "file_name" => name, "Content-Disposition" => "attachment; filename='#{name}'", "oauth_body_hash" => sha1})
  end

  def delete_response(method_url)
    @token = $access_token
    response = @token.delete(method_url)
  end

  def create_request_url(method_url, options=nil)
    req = String.new
    req << method_url
    if options
      n = 0
      options.each do |key, value|
        n == 0 ? req << "?" : req << "&"
        req << "#{key}=#{value}"
        n += 1
      end
    end
    return req
  end

end