# Copy over our stylesheets and partials...
FileUtils.cp File.join(File.dirname(__FILE__), 'public/stylesheets/graphy_default.css'), File.join(File.dirname(__FILE__), '../../../public/stylesheets')
FileUtils.cp File.join(File.dirname(__FILE__), 'views/layouts/_horizontal_graphs.rhtml'), File.join(File.dirname(__FILE__), '../../../app/views/layouts')
FileUtils.cp File.join(File.dirname(__FILE__), 'views/layouts/_vertical_graphs.rhtml'), File.join(File.dirname(__FILE__), '../../../app/views/layouts')

# Print out our README
puts IO.read(File.join(File.dirname(__FILE__), 'README'))
