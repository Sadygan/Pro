require 'test_helper'

class TableSpecificationsControllerTest < ActionController::TestCase
  setup do
    @table_specification = table_specifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:table_specifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create table_specification" do
    assert_difference('TableSpecification.count') do
      post :create, table_specification: { article: @table_specification.article, factor: @table_specification.factor, finishing: @table_specification.finishing, finishing_for_client: @table_specification.finishing_for_client, increment_discount: @table_specification.increment_discount, number_of: @table_specification.number_of, required: @table_specification.required, size: @table_specification.size, specific_id: @table_specification.specific_id, summ: @table_specification.summ, summ_netto: @table_specification.summ_netto, type_fyrniture: @table_specification.type_fyrniture, unit_price: @table_specification.unit_price, unit_price_factory: @table_specification.unit_price_factory, unit_price_netto: @table_specification.unit_price_netto, unit_v: @table_specification.unit_v }
    end

    assert_redirected_to table_specification_path(assigns(:table_specification))
  end

  test "should show table_specification" do
    get :show, id: @table_specification
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @table_specification
    assert_response :success
  end

  test "should update table_specification" do
    patch :update, id: @table_specification, table_specification: { article: @table_specification.article, factor: @table_specification.factor, finishing: @table_specification.finishing, finishing_for_client: @table_specification.finishing_for_client, increment_discount: @table_specification.increment_discount, number_of: @table_specification.number_of, required: @table_specification.required, size: @table_specification.size, specific_id: @table_specification.specific_id, summ: @table_specification.summ, summ_netto: @table_specification.summ_netto, type_fyrniture: @table_specification.type_fyrniture, unit_price: @table_specification.unit_price, unit_price_factory: @table_specification.unit_price_factory, unit_price_netto: @table_specification.unit_price_netto, unit_v: @table_specification.unit_v }
    assert_redirected_to table_specification_path(assigns(:table_specification))
  end

  test "should destroy table_specification" do
    assert_difference('TableSpecification.count', -1) do
      delete :destroy, id: @table_specification
    end

    assert_redirected_to table_specifications_path
  end
end
