module Api
  module V1
    class FollowingsController < ApplicationController
      skip_before_action :verify_authenticity_token
      # before_action :set_following, only: %i[ show edit update destroy ]

      # GET /followings or /followings.json
      def index
        render json: Following.all, status: :ok
      end

      # GET /followings/1 or /followings/1.json
      def show
        @following = Following.find_by(id: params[:id])
        if (@following!=nil)
            render json: @following, status: :ok
        else
            render json: :nothing, status: :not_found      
        end
      end

      # GET /followings/new
      def new
        @following = Following.new
      end

      # GET /followings/1/edit
      def edit
      end

      # POST /followings or /followings.json
      def create
        @following = Following.new(following_params)

        respond_to do |format|
          if @following.save
            format.html { redirect_to following_url(@following), notice: "Following was successfully created." }
            format.json { render :show, status: :created, location: @following }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @following.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /followings/1 or /followings/1.json
      def update
        respond_to do |format|
          if @following.update(following_params)
            format.html { redirect_to following_url(@following), notice: "Following was successfully updated." }
            format.json { render :show, status: :ok, location: @following }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @following.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /followings/1 or /followings/1.json
      def destroy
        @following.destroy

        respond_to do |format|
          format.html { redirect_to followings_url, notice: "Following was successfully destroyed." }
          format.json { head :no_content }
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_following
          @following = Following.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def following_params
          params.require(:following).permit(:follower, :followed)
        end
    end
  end
end