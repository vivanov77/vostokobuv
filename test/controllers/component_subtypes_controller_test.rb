require 'test_helper'

class ComponentSubtypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @component_subtype = component_subtypes(:one)
  end

  test "should get index" do
    get component_subtypes_url
    assert_response :success
  end

  test "should get new" do
    get new_component_subtype_url
    assert_response :success
  end

  test "should create component_subtype" do
    assert_difference('ComponentSubtype.count') do
      post component_subtypes_url, params: { component_subtype: {  } }
    end

    assert_redirected_to component_subtype_url(ComponentSubtype.last)
  end

  test "should show component_subtype" do
    get component_subtype_url(@component_subtype)
    assert_response :success
  end

  test "should get edit" do
    get edit_component_subtype_url(@component_subtype)
    assert_response :success
  end

  test "should update component_subtype" do
    patch component_subtype_url(@component_subtype), params: { component_subtype: {  } }
    assert_redirected_to component_subtype_url(@component_subtype)
  end

  test "should destroy component_subtype" do
    assert_difference('ComponentSubtype.count', -1) do
      delete component_subtype_url(@component_subtype)
    end

    assert_redirected_to component_subtypes_url
  end
end
