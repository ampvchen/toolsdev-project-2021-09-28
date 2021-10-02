class LocationsController < ApplicationController
  before_action :set_location, only: %i[show]

  def index
    @locations = Location.all

    respond_to do |format|
      format.json { render @locations, status: :ok }
    end
  end

  def show
  end

  private
  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:location_id)
  end
end
