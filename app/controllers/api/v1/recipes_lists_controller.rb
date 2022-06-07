module Api
  module V1
    class RecipesListsController < ApplicationController
      skip_before_action :verify_authenticity_token
      # before_action :set_recipes_list, only: %i[ show edit update destroy ]

      # GET /recipes_lists or /recipes_lists.json
      def index
        render json: RecipesList.all, status: :ok
      end

      # GET /recipes_lists/1 or /recipes_lists/1.json
      def show
        @recipe_ingredients = RecipesList.where(list_id: params[:id])
        if (@recipe_ingredients!=nil)
            render json: @recipe_ingredients, status: :ok
        else
            render json: :nothing, status: :not_found      
        end
      end

      # GET /recipes_lists/new
      def new
        @recipes_list = RecipesList.new
      end

      # GET /recipes_lists/1/edit
      def edit
      end

      # POST /recipes_lists or /recipes_lists.json
      def create
        @recipes_list = RecipesList.new(list_id: recipes_list_params[:list_id], recipe_id: recipes_list_params[:recipe_id])
        
        respond_to do |format|
          if @recipes_list.save
     
            Post.create(user_id: recipes_list_params[:user_id], recipe_id: recipes_list_params[:recipe_id], list_id: recipes_list_params[:list_id])
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
          params.require(:recipes_list).permit(:list_id, :recipe_id, :user_id)
        end
    end
  end
end