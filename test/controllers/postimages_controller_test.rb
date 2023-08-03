require "test_helper"

class PostimagesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get postimages_new_url
    assert_response :success
  end

  test "should get index" do
    get postimages_index_url
    assert_response :success
  end

  test "should get create" do
    get postimages_create_url
    assert_response :success
  end

  test "should get edit" do
    get postimages_edit_url
    assert_response :success
  end

  test "should get show" do
    get postimages_show_url
    assert_response :success
  end

  test "should get update" do
    get postimages_update_url
    assert_response :success
  end

  test "should get destroy" do
    get postimages_destroy_url
    assert_response :success
  end
end
