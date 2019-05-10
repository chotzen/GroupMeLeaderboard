require 'test_helper'

class BodemControllerTest < ActionDispatch::IntegrationTest
  test "should get scanner" do
    get bodem_scanner_url
    assert_response :success
  end

end
