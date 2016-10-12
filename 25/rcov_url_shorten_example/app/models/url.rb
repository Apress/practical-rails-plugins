class Url < ActiveRecord::Base
  validates_presence_of :url
  validates_uniqueness_of :shortcode
  after_validation :ensure_shortcode_exists
  def ensure_shortcode_exists
    if self.shortcode.nil?
      until !self.shortcode.nil? && Url.find_by_shortcode(self.shortcode).nil?
        self.shortcode = Digest::MD5.hexdigest("#{self.url}_" <<
                                               "#{Time.now.to_f.to_s}#{rand(1024)}"
                                              ).to_i(16).to_s(32)
      end
    end
  end
end
