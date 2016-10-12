require File.dirname(__FILE__) + '/../test_helper'
class UrlTest < ActiveSupport::TestCase
  def test_url_is_required
    test_url = Url.new(:url=>nil, :shortcode=>'very_short_code')
    assert !test_url.valid?
    assert test_url.errors.invalid?(:url)
  end
end
