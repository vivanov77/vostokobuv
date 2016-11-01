require 'test_helper'

class CategoryTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category_type = category_types(:one)
  end

  test "should get index" do
    get category_types_url
    assert_response :success
  end

  test "should get new" do
    get new_category_type_url
    assert_response :success
  end

  test "should create category_type" do
    assert_difference('CategoryType.count') do
      post category_types_url, params: { category_type: { Наименование: @category_type.title } }
    end

    assert_redirected_to category_type_url(CategoryType.last)
  end

  test "should show category_type" do
    get category_type_url(@category_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_category_type_url(@category_type)
    assert_response :success
  end

  test "should update category_type" do
    patch category_type_url(@category_type), params: { category_type: { Наименование: @category_type.title } }
    assert_redirected_to category_type_url(@category_type)
  end

  test "should destroy category_type" do
    assert_difference('CategoryType.count', -1) do
      delete category_type_url(@category_type)
    end

    assert_redirected_to category_types_url
  end
end
