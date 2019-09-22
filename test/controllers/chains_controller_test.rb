require 'test_helper'

class ChainsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get chains_index_url
    assert_response :success
  end

  test "should get show" do
    get chains_show_url
    assert_response :success
  end

  test "should get new" do
    get chains_new_url
    assert_response :success
  end

  test "should get create" do
    get chains_create_url
    assert_response :success
  end

  test "should get activate" do
    get chains_activate_url
    assert_response :success
  end

  test "should get deactivate" do
    get chains_deactivate_url
    assert_response :success
  end

end
