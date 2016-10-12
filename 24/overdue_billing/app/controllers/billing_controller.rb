class BillingController < ApplicationController
  def index
  end
  def envelopes
    @customers = get_delinquent_customers
  end
  def letters
    @customers = get_delinquent_customers
  end
protected
  def get_delinquent_customers
    Customer.find(:all,
                        :include=>[:invoices],
                        :conditions=>['invoices.due_on < date("NOW")'],
                        :group=>['invoices.customer_id ' <<
                                        ' HAVING count(invoices.id)>0']
                  )
  end
end

