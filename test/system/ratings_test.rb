require "application_system_test_case"

class RatingsTest < ApplicationSystemTestCase
  setup do
    @rating = ratings(:one)
  end

  test "visiting the index" do
    visit ratings_url
    assert_selector "h1", text: "Ratings"
  end

  test "should create rating" do
    visit ratings_url
    click_on "New rating"

    fill_in "Rating", with: @rating.rating
    fill_in "Recipe", with: @rating.recipe_id
    fill_in "User", with: @rating.user_id
    click_on "Create Rating"

    assert_text "Rating was successfully created"
    click_on "Back"
  end

  test "should update Rating" do
    visit rating_url(@rating)
    click_on "Edit this rating", match: :first

    fill_in "Rating", with: @rating.rating
    fill_in "Recipe", with: @rating.recipe_id
    fill_in "User", with: @rating.user_id
    click_on "Update Rating"

    assert_text "Rating was successfully updated"
    click_on "Back"
  end

  test "should destroy Rating" do
    visit rating_url(@rating)
    click_on "Destroy this rating", match: :first

    assert_text "Rating was successfully destroyed"
  end
end
