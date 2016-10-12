class User < ActiveRecord::Base
  has_many :track_listens
end

