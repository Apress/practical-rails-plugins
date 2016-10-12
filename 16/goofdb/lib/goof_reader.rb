class GoofReader
  MOVIE_LINE = /^# (.*) \((\d+)\)$/ 
  GOOF_LINE = /^- (.*): (.*)$/
  GOOF_EXT_LINE = /(\w+.*)$/
  BLANK_LINE = /^\s*$/

  def self.import(io)
    movie = nil
    goof = nil
    io.each_line do |line|
      if matches = MOVIE_LINE.match(line)
        movie = Movie.find_by_name_and_year(matches[1], matches[2])
        if movie.nil?
          movie = Movie.create(:name => matches[1],
                               :year => matches[2])
        end
      elsif !movie.nil? && matches = GOOF_LINE.match(line)
        goof = movie.goofs.build(:goof_type => matches[1],
                                 :description => matches[2])
      elsif !goof.nil? && matches = GOOF_EXT_LINE.match(line)
        goof.description = "#{goof.description} #{matches[1]}"
      elsif !goof.nil? && matches = BLANK_LINE.match(line)
        goof.save
        puts("Saved goof #{goof.id} for: #{goof.movie.name} (#{goof.movie.year})")
        goof = nil
      else
        movie = nil
      end
    end
  end
end
