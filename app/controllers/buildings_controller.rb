class BuildingsController < ApplicationController
  before_action :set_building, only: [:show, :edit, :update, :destroy]

  # GET /buildings
  def index
    @buildings = Building.all
  end

  # GET /buildings/1
  def show
  end

  # POST /buildings
  def create
    @address = building_params["address"]
    @borough = building_params["borough"]
    

    borough_true = true if (@borough == "Brooklyn" or @borough == "Bronx" or @borough == "Manhattan" or @borough == "Queens" or @borough == "Staten Island") 

    if @address.empty? or !borough_true
      # user did not enter anything in these fields
      redirect_to ('/')
      # Need to return an error message
    else
      # Need to check if it exist

      zipcode = AddressValidation.get_zip(@address, @borough)      

      if zipcode.empty?
        redirect_to ('/')
      else
      
        if !(@building = Building.where(borough: @borough, address: @address)).empty?
          # building exists in our system
          @building = @building.first
          redirect_to @building
        else
          @building = Building.new(building_params)
          @building.save
          redirect_to @building
        end
      end    
    end
  end

  # PATCH/PUT /buildings/1
  def update
   
    if @building.rating_count.nil?
      @building.rating_count = 1
      @building.rating_sum = params['rating'].to_i
      @building.save
    else
      @building.rating_count += 1
      @building.rating_sum += params['rating'].to_i
      @building.save
    end
    redirect_to @building
  end

  # DELETE /buildings/1
  def destroy
    @building.destroy
    respond_to do |format|
      format.html { redirect_to buildings_url, notice: 'Building was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_building
      @building = Building.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def building_params
      params.require(:building).permit(:address, :borough)
    end
end

class AddressValidation

  def self.get_zip (address, borough)
      address_xml = address.strip.gsub(/[ ]/, '%20')
      xml = "http://production.shippingapis.com/ShippingAPITest.dll?API=Verify%20&XML=%3CAddressValidateRequest%20USERID=%22055FLATI0094%22%3E%3CAddress%20ID=%221%22%3E%3CAddress1%3E%20%3C/Address1%3E%3CAddress2%3E" + address_xml + "%3C/Address2%3E%3CCity%3E" + borough + "%3C/City%3E%20%3CState%3ENY%3C/State%3E%3CZip5%3E06371%3C/Zip5%3E%3CZip4%3E%3C/Zip4%3E%3C/Address%3E%20%3C/AddressValidateRequest%3E"
    
      doc = Nokogiri::XML(open(xml))
      return doc.xpath("//Zip5").text
  end

end
