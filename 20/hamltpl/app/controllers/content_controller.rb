require 'lorem'

class ContentController < ApplicationController
  def index
    @title = "Haml is Markup Haiku"
    @author = "Sandra Willoughby"
    @author_website = "http://www.apress.com"
    @published_at = Time.now
    @content = []
    4.times do
      @content << Lorem::Base.new('paragraphs', 1).output
    end
  end
end

