require "application_system_test_case"

class FolowedListsTest < ApplicationSystemTestCase
  setup do
    @folowed_list = folowed_lists(:one)
  end

  test "visiting the index" do
    visit folowed_lists_url
    assert_selector "h1", text: "Folowed lists"
  end

  test "should create folowed list" do
    visit folowed_lists_url
    click_on "New folowed list"

    fill_in "List", with: @folowed_list.list_id
    fill_in "User", with: @folowed_list.user_id
    click_on "Create Folowed list"

    assert_text "Folowed list was successfully created"
    click_on "Back"
  end

  test "should update Folowed list" do
    visit folowed_list_url(@folowed_list)
    click_on "Edit this folowed list", match: :first

    fill_in "List", with: @folowed_list.list_id
    fill_in "User", with: @folowed_list.user_id
    click_on "Update Folowed list"

    assert_text "Folowed list was successfully updated"
    click_on "Back"
  end

  test "should destroy Folowed list" do
    visit folowed_list_url(@folowed_list)
    click_on "Destroy this folowed list", match: :first

    assert_text "Folowed list was successfully destroyed"
  end
end
