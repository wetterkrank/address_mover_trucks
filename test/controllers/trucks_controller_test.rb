require 'test_helper'

class TrucksControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get trucks_show_url
    assert_response :success
  end

  test "should get new" do
    get trucks_new_url
    assert_response :success
  end

  test "should get create" do
    get trucks_create_url
    assert_response :success
  end

end
