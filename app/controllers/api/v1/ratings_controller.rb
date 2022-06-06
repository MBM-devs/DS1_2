module Api
  module V1  
    class RatingsController < ApplicationController
      skip_before_action :verify_authenticity_token
      # before_action :set_rating, only: %i[ show edit update destroy ]

      # GET /ratings or /ratings.json
      def index
        render json: Rating.all, status: :ok
      end

      # GET /ratings/1 or /ratings/1.json
      def show
        @rating = Rating.where(recipe_id: params[:id])
        if (@rating!=nil)
            render json: @rating, status: :ok
        else
            render json: :nothing, status: :not_found      
        end
      end

      # GET /ratings/new
      def new
        @rating = Rating.new
      end

      # GET /ratings/1/edit
      def edit
      end

      # POST /ratings or /ratings.json
      def create
        @rating = Rating.new(rating_params)

        respond_to do |format|
          if @rating.save
            format.html { redirect_to rating_url(@rating), notice: "Rating was successfully created." }
            format.json { render :show, status: :created, location: @rating }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @rating.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /ratings/1 or /ratings/1.json
      def update
        respond_to do |format|
          if @rating.update(rating_params)
            format.html { redirect_to rating_url(@rating), notice: "Rating was successfully updated." }
            format.json { render :show, status: :ok, location: @rating }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @rating.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /ratings/1 or /ratings/1.json
      def destroy
        @rating.destroy

        respond_to do |format|
          format.html { redirect_to ratings_url, notice: "Rating was successfully destroyed." }
          format.json { head :no_content }
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_rating
          @rating = Rating.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def rating_params
          params.require(:rating).permit(:user_id, :recipe_id, :rating)
        end
    end
  end
end