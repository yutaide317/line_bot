require 'test_helper'

class LineBotsControllerTest < ActionDispatch::IntegrationTest
  test "should get client" do
    get line_bots_client_url
    assert_response :success
  end

  test "should get collback" do
    get line_bots_collback_url
    assert_response :success
  end

end
