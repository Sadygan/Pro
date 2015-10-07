require 'test_helper'

class SizeImagesControllerTest < ActionController::TestCase
  setup do
    @size_image = size_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:size_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create size_image" do
    assert_difference('SizeImage.count') do
      post :create, size_image: {  }
    end

    assert_redirected_to size_image_path(assigns(:size_image))
  end

  test "should show size_image" do
    get :show, id: @size_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @size_image
    assert_response :success
  end

  test "should update size_image" do
    patch :update, id: @size_image, size_image: {  }
    assert_redirected_to size_image_path(assigns(:size_image))
  end

  test "should destroy size_image" do
    assert_difference('SizeImage.count', -1) do
      delete :destroy, id: @size_image
    end

    assert_redirected_to size_images_path
  end
end
