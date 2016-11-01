require 'test_helper'

class ComponentCategoryTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @component_category_type = component_category_types(:one)
  end

  test "should get index" do
    get component_category_types_url
    assert_response :success
  end

  test "should get new" do
    get new_component_category_type_url
    assert_response :success
  end

  test "should create component_category_type" do
    assert_difference('ComponentCategoryType.count') do
      post component_category_types_url, params: { component_category_type: {  } }
    end

    assert_redirected_to component_category_type_url(ComponentCategoryType.last)
  end

  test "should show component_category_type" do
    get component_category_type_url(@component_category_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_component_category_type_url(@component_category_type)
    assert_response :success
  end

  test "should update component_category_type" do
    patch component_category_type_url(@component_category_type), params: { component_category_type: {  } }
    assert_redirected_to component_category_type_url(@component_category_type)
  end

  test "should destroy component_category_type" do
    assert_difference('ComponentCategoryType.count', -1) do
      delete component_category_type_url(@component_category_type)
    end

    assert_redirected_to component_category_types_url
  end
end
