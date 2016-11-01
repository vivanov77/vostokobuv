require 'test_helper'

class UserNewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_news = user_news(:one)
  end

  test "should get index" do
    get user_news_index_url
    assert_response :success
  end

  test "should get new" do
    get new_user_news_url
    assert_response :success
  end

  test "should create user_news" do
    assert_difference('UserNews.count') do
      post user_news_index_url, params: { user_news: { content: @user_news.content, delta: @user_news.delta, Наименование: @user_news.title, user_id: @user_news.user_id } }
    end

    assert_redirected_to user_news_url(UserNews.last)
  end

  test "should show user_news" do
    get user_news_url(@user_news)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_news_url(@user_news)
    assert_response :success
  end

  test "should update user_news" do
    patch user_news_url(@user_news), params: { user_news: { content: @user_news.content, delta: @user_news.delta, Наименование: @user_news.title, user_id: @user_news.user_id } }
    assert_redirected_to user_news_url(@user_news)
  end

  test "should destroy user_news" do
    assert_difference('UserNews.count', -1) do
      delete user_news_url(@user_news)
    end

    assert_redirected_to user_news_index_url
  end
end
