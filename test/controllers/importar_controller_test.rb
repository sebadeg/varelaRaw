require 'test_helper'

class ImportarControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get importar_index_url
    assert_response :success
  end

  test "should get grados" do
    get importar_grados_url
    assert_response :success
  end

end
