class USGSReader
  FEATURE_MAP = {
    'Feature_ID' => 'usgs_id',
    'Feature_Name' => 'name',
    'Class' => 'type',
    'State_Alpha' => 'state',
    'County' => 'county',
    'Primary_lat_DEC' => 'latitude',
    'Primary_lon_DEC' => 'longitude'
  }

  def self.import(io)
    first_line = true
    columns = []
    io.each_line do |line|
      if first_line
        columns = line.split('|')
        first_line = false
      else
        feature_data = map_features(columns, line.split('|'))
        if feature_data.delete('type') == 'Trail'
          # skip geographic features that are not trails
          trail = Trail.new(feature_data)
          puts("Saved trail: #{trail.name}") if trail.save
        end
      end
    end
  end

  private

    def self.map_features(columns, features)
      mapped = {}
      features.each_with_index do |value, i|
        column_name = columns[i]
        mapped_name = FEATURE_MAP[column_name]
        mapped[mapped_name] = value unless mapped_name.nil?
      end
      mapped
    end
end

