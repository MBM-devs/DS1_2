require "test_helper"

class FollowedListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @followed_list = followed_lists(:one)
  end

  test "should get index" do
    get followed_lists_url
    assert_response :success
  end

  test "should get new" do
    get new_followed_list_url
    assert_response :success
  end

  test "should create followed_list" do
    assert_difference("FollowedList.count") do
      post followed_lists_url, params: { followed_list: { list_id: @followed_list.list_id, user_id: @followed_list.user_id } }
    end

    assert_redirected_to followed_list_url(FollowedList.last)
  end

  test "should show followed_list" do
    get followed_list_url(@followed_list)
    assert_response :success
  end

  test "should get edit" do
    get edit_followed_list_url(@followed_list)
    assert_response :success
  end

  test "should update followed_list" do
    patch followed_list_url(@followed_list), params: { followed_list: { list_id: @followed_list.list_id, user_id: @followed_list.user_id } }
    assert_redirected_to followed_list_url(@followed_list)
  end

  test "should destroy followed_list" do
    assert_difference("FollowedList.count", -1) do
      delete followed_list_url(@followed_list)
    end

    assert_redirected_to followed_lists_url
  end
end
