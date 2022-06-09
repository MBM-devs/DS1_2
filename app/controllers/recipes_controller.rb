class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]

  # GET /recipes or /recipes.json
  def index
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
    @recipes = Recipe.all
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
  end

  # GET /recipes/new
  def new
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
  end

  # POST /recipes or /recipes.json
  def create
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: "Recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipe_url(@recipe), notice: "Recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: "Recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(:name, :people, :duration)
    end
end
