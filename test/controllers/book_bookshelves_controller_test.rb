require "test_helper"

class BookBookshelvesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get book_bookshelves_create_url
    assert_response :success
  end

  test "should get delete" do
    get book_bookshelves_delete_url
    assert_response :success
  end
end
