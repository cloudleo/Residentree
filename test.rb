require "pry"
require 'soda/client'

client = SODA::Client.new({:domain => 'data.cityofnewyork.us', :app_token => 'YWyMr1uyrgmiYaHafjeDzhk65'})
binding.pry

response = client.get("erm2-nwe9", {"$limit" => 10, :address => "860 Riverside Dr."})