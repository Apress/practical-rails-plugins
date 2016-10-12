# == Schema Information
# Schema version: 20080810205539
#
# Table name: books
#
#  id          :integer         not null, primary key
#  title       :string(255)     
#  isbn        :string(255)     
#  author      :string(255)     
#  publisher   :string(255)     
#  description :text            
#

class Book < ActiveRecord::Base
end
