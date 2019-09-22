require 'test_helper'

class MerchantsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get merchants_index_url
    assert_response :success
  end

  test "should get show" do
    get merchants_show_url
    assert_response :success
  end

  test "should get new" do
    get merchants_new_url
    assert_response :success
  end

  test "should get create" do
    get merchants_create_url
    assert_response :success
  end

  test "should get activate" do
    get merchants_activate_url
    assert_response :success
  end

  test "should get deactivate" do
    get merchants_deactivate_url
    assert_response :success
  end

  test "should get destroy" do
    get merchants_destroy_url
    assert_response :success
  end

end
