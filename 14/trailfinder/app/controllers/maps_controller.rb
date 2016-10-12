class MapsController < ApplicationController
  include GeoKit::Geocoders

  def show
    @location = params[:location]
    @radius = params[:radius]
    start = [44.540, -68.427]
    finder_options = {}

    @map = GMap.new("map_div")
    @map.control_init(:large_map => true, :map_type => true)

    if @location
      geohome = MultiGeocoder.geocode(@location)
      start = [geohome.lat, geohome.lng]
      finder_options[:origin] = start
      finder_options[:within] = @radius if @radius

      startico = GIcon.new(
          :image => "http://www.google.com/mapfiles/dd-start.png",
          :icon_size => GSize.new(20, 34),
          :icon_anchor => GPoint.new(10, 34),
          :info_window_anchor => GPoint.new(10, 0))
      @map.overlay_init(GMarker.new(start,
          :icon => startico,
          :title => "Home",
          :info_window => "Home<br/>#{@location}"))
    end

    @map.center_zoom_init(start, 8)

    Trail.find(:all, finder_options).each do |trail|
      @map.overlay_init(GMarker.new(
          [trail.latitude, trail.longitude],
          :title => trail.name,
          :info_window => "#{trail.name}<br/>Distance: " +
            "#{trail.distance_to(start).to_i} Miles"))
    end
  end
end

