module Api
  module V1
    class IngredientsController < ApplicationController
      skip_before_action :verify_authenticity_token
      # before_action :set_ingredient, only: %i[ show edit update destroy ]

      # GET /ingredients or /ingredients.json
      def index
      render json: Ingredient.all, status: :ok
      end

      # GET /ingredients/1 or /ingredients/1.json
      def show
        @ingredient = Ingredient.find_by(id: params[:id])
        if (@ingredient!=nil)
            render json: @ingredient, status: :ok
        else
            render json: :nothing, status: :not_found      
        end
      end

      # GET /ingredients/new
      def new
        @ingredient = Ingredient.new
      end

      # GET /ingredients/1/edit
      def edit
      end

      # POST /ingredients or /ingredients.json
      def create
        existe = Ingredient.find_by(name: ingredient_params[:name])
        if (existe == nil)
          @ingredient = Ingredient.new(name: ingredient_params[:name])
        else
          @ingredient = existe
        end

        respond_to do |format|
          if @ingredient.save
            if(params[:recipe_id] != nil)
              RecipeIngredient.create(recipe_id: ingredient_params[:recipe_id], ingredient_id: @ingredient.id, quantity: ingredient_params[:quantity], unit: ingredient_params[:unit])
            end
            # format.html { redirect_to ingredient_url(@ingredient), notice: "Ingredient was successfully created." }
            format.json { render "ingredients/show", status: :created, location: @ingredient }
            # format.json { render :show, status: :created, location: @ingredient }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @ingredient.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /ingredients/1 or /ingredients/1.json
      def update
        respond_to do |format|
          if @ingredient.update(ingredient_params)
            format.html { redirect_to ingredient_url(@ingredient), notice: "Ingredient was successfully updated." }
            format.json { render :show, status: :ok, location: @ingredient }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @ingredient.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /ingredients/1 or /ingredients/1.json
      def destroy
        @ingredient.destroy

        respond_to do |format|
          format.html { redirect_to ingredients_url, notice: "Ingredient was successfully destroyed." }
          format.json { head :no_content }
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_ingredient
          @ingredient = Ingredient.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def ingredient_params
          params.require(:ingredient).permit(:name, :quantity, :unit, :recipe_id)
        end
    end
  end
end