require 'test_helper'

class CajaControllerTest < ActionDispatch::IntegrationTest
  test "should get servicios" do
    get caja_servicios_url
    assert_response :success
  end

end
