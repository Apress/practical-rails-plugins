class CreateSoftwareProjects < ActiveRecord::Migration
  def self.up
    create_table :software_projects do |t|
      t.string :name
      t.string :maintainer_name
      t.string :maintainer_email
      t.string :project_url
      t.boolean :commercial_support_available
      t.string :commercial_sales_number
      t.timestamps
    end
  end
  def self.down
    drop_table :software_projects
  end
end

