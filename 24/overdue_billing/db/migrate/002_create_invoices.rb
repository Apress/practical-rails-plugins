class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.date :due_on
      t.decimal :amount, :precision => 8, :scale => 2
      t.integer :customer_id
      t.timestamps
    end
  end
  def self.down
    drop_table :invoices
  end
end

