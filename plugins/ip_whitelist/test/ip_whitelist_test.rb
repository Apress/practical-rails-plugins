require File.expand_path(File.join(File.dirname(__FILE__), '../../../../config/environment.rb'))
require File.dirname(__FILE__) + '/../lib/ip_whitelist.rb'

require 'test/unit'
 require 'action_controller'
require 'action_controller/test_process'

class IpWhitelistTest < Test::Unit::TestCase
  class ::SampleController < ::ActionController::Base
    include IpWhitelist
    allow_from_ip ["127.0.0.1"], :only => :acta

    def acta; render(:nothing => true) end
    def actb; render(:nothing => true) end
  end

  def setup
    @controller = SampleController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end

  def test_action_protected
    get :acta # addr not in whitelist (0.0.0.0)
    assert_response 401
  end

  def test_remote_addr_in_whitelist
    @request.remote_addr = "127.0.0.1"
    get :acta # addr in whitelist
    assert_response :success
  end

  def test_not_included
    get :actb # unprotected
    assert_response :success
  end
end

