require 'test_helper'

class FactoriesControllerTest < ActionController::TestCase
  setup do
    @factory = factories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:factories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create factory" do
    assert_difference('Factory.count') do
      post :create, factory: { additional_discount: @factory.additional_discount, autorification: @factory.autorification, brand: @factory.brand, catalog: @factory.catalog, delivery_terms: @factory.delivery_terms, discount: @factory.discount, line_product: @factory.line_product, note: @factory.note, price: @factory.price, style: @factory.style, web: @factory.web }
    end

    assert_redirected_to factory_path(assigns(:factory))
  end

  test "should show factory" do
    get :show, id: @factory
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @factory
    assert_response :success
  end

  test "should update factory" do
    patch :update, id: @factory, factory: { additional_discount: @factory.additional_discount, autorification: @factory.autorification, brand: @factory.brand, catalog: @factory.catalog, delivery_terms: @factory.delivery_terms, discount: @factory.discount, line_product: @factory.line_product, note: @factory.note, price: @factory.price, style: @factory.style, web: @factory.web }
    assert_redirected_to factory_path(assigns(:factory))
  end

  test "should destroy factory" do
    assert_difference('Factory.count', -1) do
      delete :destroy, id: @factory
    end

    assert_redirected_to factories_path
  end
end
