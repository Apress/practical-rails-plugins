class Trail < ActiveRecord::Base
  acts_as_mappable :lat_column_name => 'latitude', :lng_column_name => 'longitude'

  validates_presence_of :name, :usgs_id, :latitude, :longitude
  validates_uniqueness_of :name, :usgs_id
end

