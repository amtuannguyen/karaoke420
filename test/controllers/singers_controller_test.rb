require 'test_helper'

class SingersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get singers_url
    assert_response :success
  end
end
