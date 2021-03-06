require 'integration/test_helper'

class ApplicationControllerTest < ActionController::TestCase
  tests ApplicationController

  describe "#current_user" do
    it "returns nil if no current user" do
      @controller.current_user.must_be_nil
    end

    it "finds the user according to the web token cookie" do
      user = User.new
      FindUser.any_instance.expects(:by_login_token).
        with(:web, "1234567890").returns(user)

      @request.cookies[:web_session_token] = "1234567890"

      @controller.current_user.must_equal user
    end

  end

end