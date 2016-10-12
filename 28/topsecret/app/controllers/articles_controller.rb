class ArticlesController < ApplicationController
  allow_from_ip ["192.168.1.1", "10.20.30.40"]

  def index
    render(:text => "It works!  Your IP must be in the whitelist.")
  end
end

