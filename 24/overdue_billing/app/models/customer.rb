class Customer < ActiveRecord::Base
  has_many :invoices
  def past_due_invoices
    self.invoices.find(:all, :conditions=>['invoices.due_on < date("NOW")'])
  end
end

