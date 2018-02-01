require "application_system_test_case"

class KaraokeTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_url
    assert_selector "h1", text: "Sing"
  end
end
