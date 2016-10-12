class Signature < ActiveRecord::Base
  belongs_to :petition

  validates_presence_of :name, :email, :petition_id
  validates_uniqueness_of :email, :scope => :petition_id
end
