require 'test_helper'

class AmChartsControllerTest < ActionController::TestCase
  test "should get mygraph" do
    get :mygraph
    assert_response :success
  end

end
