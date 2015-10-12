require "open-uri"
require "json"

require 'pry'

class Building < ActiveRecord::Base
  extend FriendlyId
  friendly_id :address, use: :slugged

  validates :address, :presence => {:message => "Please enter an address."}
  validates :borough, :presence => {:message => "Please choose a borough."}
  
  

  # def get_result(address, borough)
  #   "https://data.cityofnewyork.us/resource/erm2-nwe9.json?$order=created_date%20DESC&$limit=20&$where=incident_address%20=%27#{address.upcase}%27&%$where=Borough%20=%27#{borough}%27" 
  # end

  # def get_json(url)
  #   return JSON.load(open(url))
  # end

     def get_access(address, borough)   
      if address.upcase.include? "ST"||"ST."
       address = address.split(" ").map! do |m|
            if m == "ST" || m == "ST."
              m = "STREET"
            else
              m = m
            end
          end
        address.join(" ")
       elsif address.upcase.include? "AVE"||"AVE."
        address = address.gsub "AVE", "AVENUE"
      elsif address.upcase.include? "DR"||"DR."
        address = address.gsub "DR", "DRIVE"
      else
        address
      end
      
         client = SODA::Client.new({:domain => "data.cityofnewyork.us", :app_token => "YWyMr1uyrgmiYaHafjeDzhk65"})
         response = client.get("fhrw-4uyv", {"$order" => "created_date DESC", "$limit" => 30, "$q" => address, :borough => borough})
     
     return response
     end
end

