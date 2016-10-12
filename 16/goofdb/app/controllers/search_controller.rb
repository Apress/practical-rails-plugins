class SearchController < ApplicationController
  def show
    @search = params[:query]
    if !@search.nil? && !@search.blank?
      @time_for_search = Benchmark.realtime do
        @results = Ultrasphinx::Search.new(:query => @search).run.results
      end
      render(:action => 'show')
    else
      render(:action => '_form')
    end
  end
end
