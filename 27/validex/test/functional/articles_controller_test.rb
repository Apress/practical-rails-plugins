require File.dirname(__FILE__) + '/../test_helper'

class ArticlesControllerTest < ActionController::TestCase
  assert_valid_markup :index, :show
  assert_valid_css_files 'application'
end

