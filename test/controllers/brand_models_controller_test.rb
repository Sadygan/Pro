require 'test_helper'

class BrandModelsControllerTest < ActionController::TestCase
  setup do
    @brand_model = brand_models(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:brand_models)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create brand_model" do
    assert_difference('BrandModel.count') do
      post :create, brand_model: { name: @brand_model.name }
    end

    assert_redirected_to brand_model_path(assigns(:brand_model))
  end

  test "should show brand_model" do
    get :show, id: @brand_model
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @brand_model
    assert_response :success
  end

  test "should update brand_model" do
    patch :update, id: @brand_model, brand_model: { name: @brand_model.name }
    assert_redirected_to brand_model_path(assigns(:brand_model))
  end

  test "should destroy brand_model" do
    assert_difference('BrandModel.count', -1) do
      delete :destroy, id: @brand_model
    end

    assert_redirected_to brand_models_path
  end
end
