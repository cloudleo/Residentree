require "open-uri"
require "json"
require 'pry'

class Building < ActiveRecord::Base
  validates :address, :presence => {:message => "Please enter an address."}
  
  def get_result(address, borough)
    "https://data.cityofnewyork.us/resource/erm2-nwe9.json?$where=incident_address%20=%27#{address.upcase}%27&%$where=borough%20=%27#{borough}%27&$order=created_date%20DESC&$limit=1" 
  end

  def get_json(url)
    return JSON.load(open(url))
  end
end

