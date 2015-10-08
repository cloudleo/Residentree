require "open-uri"
require "json"
require 'pry'

class Building < ActiveRecord::Base
  extend FriendlyId
  friendly_id :address, use: :slugged

  validates :address, :presence => {:message => "Please enter an address."}
  validates :borough, :presence => {:message => "Please choose a borough."}
  
  def get_result(address, borough)
    "https://data.cityofnewyork.us/resource/erm2-nwe9.json?$order=created_date%20DESC&$limit=20&$where=incident_address%20=%27#{address.upcase}%27&%$where=Borough%20=%27#{borough}%27" 
  end

  def get_json(url)
    return JSON.load(open(url))
  end

  def get_access(address, borough)
    # binding.pry
     return self.get_json(self.get_result(address.upcase, borough))
     end
end

