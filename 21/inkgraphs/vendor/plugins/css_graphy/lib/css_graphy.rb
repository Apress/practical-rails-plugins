module CssGraphy

  module Helpers

    def horizontal_graph(array_of_hashes, options={})
      graph(array_of_hashes, 'app/views/layouts/_horizontal_graphs.rhtml', options)
    end # horizontal_graph

    def vertical_graph(array_of_hashes, options={})
      graph(array_of_hashes, 'app/views/layouts/_vertical_graphs.rhtml', options)
    end # vertical_graph

    def graphy_stylesheet(theme='default')
      stylesheet_link_tag 'graphy_' + theme
    end # graphy_stylesheet

    private

      def graph(array_of_hashes, template, options={})
        default_options = { :format => '%0.2f', :graph_width => '300', :graph_height => '300' }
        @options = default_options.merge(options)
        @array_of_hashes = array_of_hashes

        unless(@options[:max_value])
          @max_value = 0
          if (options[:accumulate])
            @array_of_hashes.each { |row| @max_value += row['value'].to_f }
          else
            @array_of_hashes.each { |row| @max_value = row['value'].to_f if (@max_value < row['value'].to_f) }
            @max_value = @max_value * 1.1
          end
        else
          @max_value = @options[:max_value]
        end

        erb = ERB.new(File.open(template).read, nil, ActionView::Base.erb_trim_mode).result(binding)

      end # def graph

  end # module Helpers

end # module CssGraphy

