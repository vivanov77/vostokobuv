require 'test_helper'

class CategoryValuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category_value = category_values(:one)
  end

  test "should get index" do
    get category_values_url
    assert_response :success
  end

  test "should get new" do
    get new_category_value_url
    assert_response :success
  end

  test "should create category_value" do
    assert_difference('CategoryValue.count') do
      post category_values_url, params: { category_value: { Наименование: @category_value.title } }
    end

    assert_redirected_to category_value_url(CategoryValue.last)
  end

  test "should show category_value" do
    get category_value_url(@category_value)
    assert_response :success
  end

  test "should get edit" do
    get edit_category_value_url(@category_value)
    assert_response :success
  end

  test "should update category_value" do
    patch category_value_url(@category_value), params: { category_value: { Наименование: @category_value.title } }
    assert_redirected_to category_value_url(@category_value)
  end

  test "should destroy category_value" do
    assert_difference('CategoryValue.count', -1) do
      delete category_value_url(@category_value)
    end

    assert_redirected_to category_values_url
  end
end
