require 'fastercsv'

class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :authors do |t|
      t.string :name
    end

    create_table :sections do |t|
      t.string :name
    end

    create_table :articles do |t|
      t.integer  :legacy_id
      t.string   :title
      t.string   :path
      t.string   :section_id
      t.string   :author_id
      t.datetime :published_on
    end

    FasterCSV.foreach("db/ink19.csv", :headers => true) do |row|
      author = Author.find_or_create_by_name(row['author'])
      section = Section.find_or_create_by_name(row['section'])
      article = Article.create(:legacy_id => row['id'], 
                               :title => row['title'],
                               :path => row['path'], 
                               :published_on => Date.parse(row['date']),
                               :author => author, 
                               :section => section)
    end
  end

  def self.down
    drop_table :authors
    drop_table :sections
    drop_table :articles
  end
end

