require 'test_helper'

class Setting1sControllerTest < ActionDispatch::IntegrationTest
  setup do
    @setting1 = setting1s(:one)
  end

  test "should get index" do
    get setting1s_url
    assert_response :success
  end

  test "should get new" do
    get new_setting1_url
    assert_response :success
  end

  test "should create setting1" do
    assert_difference('Setting1.count') do
      post setting1s_url, params: { setting1: { type: @setting1.type, value: @setting1.value } }
    end

    assert_redirected_to setting1_url(Setting1.last)
  end

  test "should show setting1" do
    get setting1_url(@setting1)
    assert_response :success
  end

  test "should get edit" do
    get edit_setting1_url(@setting1)
    assert_response :success
  end

  test "should update setting1" do
    patch setting1_url(@setting1), params: { setting1: { type: @setting1.type, value: @setting1.value } }
    assert_redirected_to setting1_url(@setting1)
  end

  test "should destroy setting1" do
    assert_difference('Setting1.count', -1) do
      delete setting1_url(@setting1)
    end

    assert_redirected_to setting1s_url
  end
end
