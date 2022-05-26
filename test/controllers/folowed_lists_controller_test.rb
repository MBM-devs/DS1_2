require "test_helper"

class FolowedListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @folowed_list = folowed_lists(:one)
  end

  test "should get index" do
    get folowed_lists_url
    assert_response :success
  end

  test "should get new" do
    get new_folowed_list_url
    assert_response :success
  end

  test "should create folowed_list" do
    assert_difference("FolowedList.count") do
      post folowed_lists_url, params: { folowed_list: { list_id: @folowed_list.list_id, user_id: @folowed_list.user_id } }
    end

    assert_redirected_to folowed_list_url(FolowedList.last)
  end

  test "should show folowed_list" do
    get folowed_list_url(@folowed_list)
    assert_response :success
  end

  test "should get edit" do
    get edit_folowed_list_url(@folowed_list)
    assert_response :success
  end

  test "should update folowed_list" do
    patch folowed_list_url(@folowed_list), params: { folowed_list: { list_id: @folowed_list.list_id, user_id: @folowed_list.user_id } }
    assert_redirected_to folowed_list_url(@folowed_list)
  end

  test "should destroy folowed_list" do
    assert_difference("FolowedList.count", -1) do
      delete folowed_list_url(@folowed_list)
    end

    assert_redirected_to folowed_lists_url
  end
end
