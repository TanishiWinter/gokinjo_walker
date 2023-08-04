require "test_helper"

class Admin::PostimagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_postimages_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_postimages_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_postimages_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_postimages_update_url
    assert_response :success
  end
end
