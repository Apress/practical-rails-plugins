require 'scrobbler'

class SidebarsController < ApplicationController
  def music
    user = Scrobbler::User.new('zapnap')
    @artists = user.weekly_artist_chart[0..10]
  end
end
