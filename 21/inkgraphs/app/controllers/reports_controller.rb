class ReportsController < ApplicationController
   include Ziya
   ARTICLE_MIN = 120
 
  before_filter :get_year

  def authors
    respond_to do |format|
      format.html # render authors.html.erb
      format.xml do
        graph = Ziya::Charts::Line.new(nil, "author_chart", "ink")
        graph.add(:theme, "ink")
        graph.add(:axis_category_text, ["Jan", "Feb", "Mar", "Apr", "May", 
          "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])

        authors_to_graph = Author.find(
          :all).select { |author| author.articles.length > ARTICLE_MIN }
        authors_to_graph.each do |author|
          graph.add(:series, author.name, 
            monthly_articles(@start_date, author.articles))
        end

        graph.add(:series, 'AVERAGE', 
          monthly_articles(@start_date, Article, :average => true))
        render(:text => graph.to_xml)
      end
    end
  end

  def sections
    @data = Section.find(:all).map do |section|
      { 'label' => section.name,
        'value' => section.articles.count(
          :conditions => ["published_on >= ? and published_on < ?", 
            @start_date, @start_date+1.year]) }
    end

    @data = @data.select { |section| section['value'] > 0 }
  end

  protected

  def get_year
    @year = params[:id] || Article.find(:first).published_on.strftime("%Y")
    @start_date = Date.strptime(@year, "%Y")
    @years = Article.find(:all, :select => "strftime('%Y', published_on) as year", 
      :group => "year").map { |a| a.year }
  end

  def monthly_articles(year, articles, options = {})
    res = []
    0.upto(11) do |i|
      articles_this_month = articles.find(:all, 
        :conditions => ["published_on >= ? and published_on < ?",
          year + i.months, year + (i+1).months])
      if articles_this_month.length > 0
        if options[:average]
          res << articles_this_month.length / 
            articles_this_month.map { |article| article.author_id }.uniq.length
        else
          res << articles_this_month.length
        end
      else
        res << 0
      end
    end

    res
  end
end

