require 'test_helper'

class DealersControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get dealers_edit_url
    assert_response :success
  end

  test "should get update" do
    get dealers_update_url
    assert_response :success
  end

end
