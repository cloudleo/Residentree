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
      # user did not enter anything in this field
      redirect_to ('/')
      # Need to return an error message
    else
      # Need to check if it exist
      
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
