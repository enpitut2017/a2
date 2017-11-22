require 'test_helper'

class ContactPageControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get contact_page_home_url
    assert_response :success
  end

  test "should get done" do
    get contact_page_done_url
    assert_response :success
  end

end
