require 'test_helper'

class TypeFurnituresControllerTest < ActionController::TestCase
  setup do
    @type_furniture = type_furnitures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:type_furnitures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create type_furniture" do
    assert_difference('TypeFurniture.count') do
      post :create, type_furniture: { name: @type_furniture.name }
    end

    assert_redirected_to type_furniture_path(assigns(:type_furniture))
  end

  test "should show type_furniture" do
    get :show, id: @type_furniture
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @type_furniture
    assert_response :success
  end

  test "should update type_furniture" do
    patch :update, id: @type_furniture, type_furniture: { name: @type_furniture.name }
    assert_redirected_to type_furniture_path(assigns(:type_furniture))
  end

  test "should destroy type_furniture" do
    assert_difference('TypeFurniture.count', -1) do
      delete :destroy, id: @type_furniture
    end

    assert_redirected_to type_furnitures_path
  end
end
