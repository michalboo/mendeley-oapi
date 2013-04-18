# encoding: UTF-8


require File.dirname(__FILE__) + '/mendeley.rb'

m = Mendeley.new
res = m.profile_information("me")
puts JSON.parse(res.body)