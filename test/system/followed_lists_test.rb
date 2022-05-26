require "application_system_test_case"

class FollowedListsTest < ApplicationSystemTestCase
  setup do
    @followed_list = followed_lists(:one)
  end

  test "visiting the index" do
    visit followed_lists_url
    assert_selector "h1", text: "Followed lists"
  end

  test "should create followed list" do
    visit followed_lists_url
    click_on "New followed list"

    fill_in "List", with: @followed_list.list_id
    fill_in "User", with: @followed_list.user_id
    click_on "Create Followed list"

    assert_text "Followed list was successfully created"
    click_on "Back"
  end

  test "should update Followed list" do
    visit followed_list_url(@followed_list)
    click_on "Edit this followed list", match: :first

    fill_in "List", with: @followed_list.list_id
    fill_in "User", with: @followed_list.user_id
    click_on "Update Followed list"

    assert_text "Followed list was successfully updated"
    click_on "Back"
  end

  test "should destroy Followed list" do
    visit followed_list_url(@followed_list)
    click_on "Destroy this followed list", match: :first

    assert_text "Followed list was successfully destroyed"
  end
end
