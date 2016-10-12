class Article < ActiveRecord::Base
  belongs_to :author
  belongs_to :section

  validates_presence_of :legacy_id, :title, :path, :author_id, 
    :section_id, :published_on
  validates_uniqueness_of :legacy_id
end

