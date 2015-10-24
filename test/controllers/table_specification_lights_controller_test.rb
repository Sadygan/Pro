require 'test_helper'

class TableSpecificationLightsControllerTest < ActionController::TestCase
  setup do
    @table_specification_light = table_specification_lights(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:table_specification_lights)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create table_specification_light" do
    assert_difference('TableSpecificationLight.count') do
      post :create, table_specification_light: { arhitec_percent: @table_specification_light.arhitec_percent, depth: @table_specification_light.depth, finishing: @table_specification_light.finishing, finishing_for_client: @table_specification_light.finishing_for_client, height: @table_specification_light.height, interest_percent: @table_specification_light.interest_percent, number_of: @table_specification_light.number_of, unit_price_factory: @table_specification_light.unit_price_factory, width: @table_specification_light.width }
    end

    assert_redirected_to table_specification_light_path(assigns(:table_specification_light))
  end

  test "should show table_specification_light" do
    get :show, id: @table_specification_light
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @table_specification_light
    assert_response :success
  end

  test "should update table_specification_light" do
    patch :update, id: @table_specification_light, table_specification_light: { arhitec_percent: @table_specification_light.arhitec_percent, depth: @table_specification_light.depth, finishing: @table_specification_light.finishing, finishing_for_client: @table_specification_light.finishing_for_client, height: @table_specification_light.height, interest_percent: @table_specification_light.interest_percent, number_of: @table_specification_light.number_of, unit_price_factory: @table_specification_light.unit_price_factory, width: @table_specification_light.width }
    assert_redirected_to table_specification_light_path(assigns(:table_specification_light))
  end

  test "should destroy table_specification_light" do
    assert_difference('TableSpecificationLight.count', -1) do
      delete :destroy, id: @table_specification_light
    end

    assert_redirected_to table_specification_lights_path
  end
end
