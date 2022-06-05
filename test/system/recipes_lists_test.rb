require "application_system_test_case"

class RecipesListsTest < ApplicationSystemTestCase
  setup do
    @recipes_list = recipes_lists(:one)
  end

  test "visiting the index" do
    visit recipes_lists_url
    assert_selector "h1", text: "Recipes lists"
  end

  test "should create recipes list" do
    visit recipes_lists_url
    click_on "New recipes list"

    fill_in "List", with: @recipes_list.list_id
    fill_in "Recipe", with: @recipes_list.recipe_id
    click_on "Create Recipes list"

    assert_text "Recipes list was successfully created"
    click_on "Back"
  end

  test "should update Recipes list" do
    visit recipes_list_url(@recipes_list)
    click_on "Edit this recipes list", match: :first

    fill_in "List", with: @recipes_list.list_id
    fill_in "Recipe", with: @recipes_list.recipe_id
    click_on "Update Recipes list"

    assert_text "Recipes list was successfully updated"
    click_on "Back"
  end

  test "should destroy Recipes list" do
    visit recipes_list_url(@recipes_list)
    click_on "Destroy this recipes list", match: :first

    assert_text "Recipes list was successfully destroyed"
  end
end
