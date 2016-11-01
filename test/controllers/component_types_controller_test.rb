require 'test_helper'

class ComponentTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @component_type = component_types(:one)
  end

  test "should get index" do
    get component_types_url
    assert_response :success
  end

  test "should get new" do
    get new_component_type_url
    assert_response :success
  end

  test "should create component_type" do
    assert_difference('ComponentType.count') do
      post component_types_url, params: { component_type: {  } }
    end

    assert_redirected_to component_type_url(ComponentType.last)
  end

  test "should show component_type" do
    get component_type_url(@component_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_component_type_url(@component_type)
    assert_response :success
  end

  test "should update component_type" do
    patch component_type_url(@component_type), params: { component_type: {  } }
    assert_redirected_to component_type_url(@component_type)
  end

  test "should destroy component_type" do
    assert_difference('ComponentType.count', -1) do
      delete component_type_url(@component_type)
    end

    assert_redirected_to component_types_url
  end
end
