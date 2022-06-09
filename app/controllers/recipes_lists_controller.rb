class RecipesListsController < ApplicationController
  before_action :set_recipes_list, only: %i[ show edit update destroy ]

  # GET /recipes_lists or /recipes_lists.json
  def index
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
    @recipes_lists = RecipesList.all
  end

  # GET /recipes_lists/1 or /recipes_lists/1.json
  def show
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
  end

  # GET /recipes_lists/new
  def new
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
    @recipes_list = RecipesList.new
  end

  # GET /recipes_lists/1/edit
  def edit
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
  end

  # POST /recipes_lists or /recipes_lists.json
  def create
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
    @recipes_list = RecipesList.new(recipes_list_params)

    respond_to do |format|
      if @recipes_list.save
        format.html { redirect_to recipes_list_url(@recipes_list), notice: "Recipes list was successfully created." }
        format.json { render :show, status: :created, location: @recipes_list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipes_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes_lists/1 or /recipes_lists/1.json
  def update
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
    respond_to do |format|
      if @recipes_list.update(recipes_list_params)
        format.html { redirect_to recipes_list_url(@recipes_list), notice: "Recipes list was successfully updated." }
        format.json { render :show, status: :ok, location: @recipes_list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipes_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes_lists/1 or /recipes_lists/1.json
  def destroy
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
    @recipes_list.destroy

    respond_to do |format|
      format.html { redirect_to recipes_lists_url, notice: "Recipes list was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipes_list
      @recipes_list = RecipesList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipes_list_params
      params.require(:recipes_list).permit(:list_id, :recipe_id)
    end
end
