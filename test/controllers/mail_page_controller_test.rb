require 'test_helper'

class MailPageControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get mail_page_home_url
    assert_response :success
  end

  test "should get done" do
    get mail_page_done_url
    assert_response :success
  end

end
