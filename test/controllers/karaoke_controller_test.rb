require 'test_helper'

class KaraokeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get karaoke_index_url
    assert_response :success
  end

end
