require "test_helper"

class RecipesListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recipes_list = recipes_lists(:one)
  end

  test "should get index" do
    get recipes_lists_url
    assert_response :success
  end

  test "should get new" do
    get new_recipes_list_url
    assert_response :success
  end

  test "should create recipes_list" do
    assert_difference("RecipesList.count") do
      post recipes_lists_url, params: { recipes_list: { list_id: @recipes_list.list_id, recipe_id: @recipes_list.recipe_id } }
    end

    assert_redirected_to recipes_list_url(RecipesList.last)
  end

  test "should show recipes_list" do
    get recipes_list_url(@recipes_list)
    assert_response :success
  end

  test "should get edit" do
    get edit_recipes_list_url(@recipes_list)
    assert_response :success
  end

  test "should update recipes_list" do
    patch recipes_list_url(@recipes_list), params: { recipes_list: { list_id: @recipes_list.list_id, recipe_id: @recipes_list.recipe_id } }
    assert_redirected_to recipes_list_url(@recipes_list)
  end

  test "should destroy recipes_list" do
    assert_difference("RecipesList.count", -1) do
      delete recipes_list_url(@recipes_list)
    end

    assert_redirected_to recipes_lists_url
  end
end
