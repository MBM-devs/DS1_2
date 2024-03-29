module Api
  module V1
    class RecipesController < ApplicationController
      skip_before_action :verify_authenticity_token
      # before_action :set_recipe, only: %i[ show edit update destroy ]

      # GET /recipes or /recipes.json
      def index
        render json: Recipe.all, status: :ok
      end

      # GET /recipes/1 or /recipes/1.json
      def show
        @recipe = Recipe.find_by(id: params[:id])
        if (@recipe!=nil)
            render json: @recipe, status: :ok
        else
            render json: :nothing, status: :not_found      
        end
      end

      # GET /recipes/new
      def new
        @recipe = Recipe.new
      end

    def rating
      @rating = 0.0;
      ratings = Rating.where(recipe_id: params[:id])
      if(ratings.count > 0)
          for entry in ratings do
              @rating += entry.rating
          end
          @rating /= ratings.count
      end
      message = {"rating": "#{@rating}"}
      respond_to do |format|
        format.json { render json: message }
      end
    end

      # GET /recipes/1/edit
      def edit
      end

      # POST /recipes or /recipes.json
      def create
        @user = User.find_by(id: recipe_params[:user_id])

        if(@user != nil)
          @recipe = Recipe.new(id: recipe_params[:id], name: recipe_params[:name], duration: recipe_params[:duration], people: recipe_params[:people])
          
          respond_to do |format|
            if @recipe.save
              Post.create(user_id: recipe_params[:user_id], recipe_id: @recipe.id)
              @mis_recetas = List.find_by(user_id: recipe_params[:user_id], name: "Recetas de #{@user.username}" );
              
              RecipesList.create(list_id: @mis_recetas.id, recipe_id: @recipe.id);
              if(recipe_params[:list_id] != nil)
                @lista = List.find_by(id: recipe_params[:list_id]);
                RecipesList.create(list_id: @lista.id, recipe_id: @recipe.id);
                Post.create(user_id: recipes_params[:user_id], recipe_id: @recipe.id, list_id: @lista.id)
              end #if

              # format.html { redirect_to recipe_url(@recipe), notice: "Recipe was successfully created." }
              format.json { render "recipes/show", status: :created, location: @recipe }
            else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: @recipe.errors, status: :unprocessable_entity }
            end #if
          end #respond
        else
          respond_to do |format|
            message = {"error": "Usuario no valido."}
            format.json { render json: message }
          end
        end #if 
      end #create

      # PATCH/PUT /recipes/1 or /recipes/1.json
      def update
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
          params.require(:recipe).permit(:name, :people, :duration, :user_id, :list_id, :url_img)
        end
    end
  end
end
