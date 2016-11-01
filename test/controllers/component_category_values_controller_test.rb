require 'test_helper'

class ComponentCategoryValuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @component_category_value = component_category_values(:one)
  end

  test "should get index" do
    get component_category_values_url
    assert_response :success
  end

  test "should get new" do
    get new_component_category_value_url
    assert_response :success
  end

  test "should create component_category_value" do
    assert_difference('ComponentCategoryValue.count') do
      post component_category_values_url, params: { component_category_value: {  } }
    end

    assert_redirected_to component_category_value_url(ComponentCategoryValue.last)
  end

  test "should show component_category_value" do
    get component_category_value_url(@component_category_value)
    assert_response :success
  end

  test "should get edit" do
    get edit_component_category_value_url(@component_category_value)
    assert_response :success
  end

  test "should update component_category_value" do
    patch component_category_value_url(@component_category_value), params: { component_category_value: {  } }
    assert_redirected_to component_category_value_url(@component_category_value)
  end

  test "should destroy component_category_value" do
    assert_difference('ComponentCategoryValue.count', -1) do
      delete component_category_value_url(@component_category_value)
    end

    assert_redirected_to component_category_values_url
  end
end
