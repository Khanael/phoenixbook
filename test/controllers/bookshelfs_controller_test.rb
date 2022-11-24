require "test_helper"

class BookshelfsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get bookshelfs_new_url
    assert_response :success
  end

  test "should get create" do
    get bookshelfs_create_url
    assert_response :success
  end

  test "should get edit" do
    get bookshelfs_edit_url
    assert_response :success
  end

  test "should get update" do
    get bookshelfs_update_url
    assert_response :success
  end

  test "should get destroy" do
    get bookshelfs_destroy_url
    assert_response :success
  end

  test "should get show" do
    get bookshelfs_show_url
    assert_response :success
  end

  test "should get index" do
    get bookshelfs_index_url
    assert_response :success
  end
end
