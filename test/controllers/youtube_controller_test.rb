require 'test_helper'

class YoutubeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get youtubes_url
    assert_response :success
  end
end
