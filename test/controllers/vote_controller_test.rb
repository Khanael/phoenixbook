require "test_helper"

class VoteControllerTest < ActionDispatch::IntegrationTest
  test "should get like" do
    get vote_like_url
    assert_response :success
  end

  test "should get dislike" do
    get vote_dislike_url
    assert_response :success
  end
end
