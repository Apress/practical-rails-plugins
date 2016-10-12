# Uninstall hook code here, clean up partials and CSS...
FileUtils.rm File.join(File.dirname(__FILE__), '../../../public/stylesheets/graphy_default.css')
FileUtils.rm File.join(File.dirname(__FILE__), '../../../app/views/layouts/_horizontal_graphs.rhtml')
FileUtils.rm File.join(File.dirname(__FILE__), '../../../app/views/layouts/_vertical_graphs.rhtml')
