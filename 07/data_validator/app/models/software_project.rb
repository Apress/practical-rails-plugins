class SoftwareProject < ActiveRecord::Base
  validates_http_url :project_url
  validates_presence_of :project_url
  validates_email_veracity_of :maintainer_email
  validates_presence_of :maintainer_email
  validates_as_phone    :commercial_sales_number,
                        :allow_blank=>true
  validates_presence_of :commercial_sales_number,
                        :if=>Proc.new { |p| p.commercial_support_available }
end

