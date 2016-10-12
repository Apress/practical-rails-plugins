class User < ActiveRecord::Base
  is_ajaxful_rater

  validates_presence_of :ip_address
  validates_uniqueness_of :ip_address
end
