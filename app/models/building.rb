require "open-uri"
require "json"
class Building < ActiveRecord::Base
require 'pry'
  extend FriendlyId
  friendly_id :address, use: :slugged

  validates :address, :presence => {:message => "Please enter an address."}
  validates :borough, :presence => {:message => "Please choose a borough."}
  
  
  #old way getting the data from the link
  # def get_result(address, borough)
  #   "https://data.cityofnewyork.us/resource/erm2-nwe9.json?$order=created_date%20DESC&$limit=20&$where=incident_address%20=%27#{address.upcase}%27&%$where=Borough%20=%27#{borough}%27" 
  # end

  # def get_json(url)
  #   return JSON.load(open(url))
  # end

  def get_access(address, borough)   
    if address.upcase.include?("ST"||"ST."|| "AVE"|| "AVE."|| "DR"|| "DR.")
      binding.pry
      address = address.split(" ").map! do |m|
        if m == "ST" || m == "ST."
          m = "STREET"
        end
        if m == "AVE" || m == "AVE."
          m = "AVENUE"
        end
        if m == "DR" || m == "DR."
              m = "DRIVE"
        end
        address.join(" ")
      end  
    else
      address
    end
     
         client = SODA::Client.new({:domain => "data.cityofnewyork.us", :app_token => "YWyMr1uyrgmiYaHafjeDzhk65"})
         response = client.get("fhrw-4uyv", {"$order" => "created_date DESC", "$limit" => 30, "$q" => address, :borough => borough})
     
     return response
     end
end

