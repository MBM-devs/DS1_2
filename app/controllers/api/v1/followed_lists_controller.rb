module Api
  module V1
    class FollowedListsController < ApplicationController
      skip_before_action :verify_authenticity_token
      # before_action :set_followed_list, only: %i[ show edit update destroy ]
    
      # GET /followed_lists or /followed_lists.json
      def index
        render json: FollowedList.all, status: :ok
      end
    
      # GET /followed_lists/1 or /followed_lists/1.json
      def show
        @followed_list = FollowedList.find_by(id: params[:id])
        if (@followed_list!=nil)
            render json: @followed_list, status: :ok
        else
            render json: :nothing, status: :not_found      
        end
      end
    
      # GET /followed_lists/new
      def new
        @followed_list = FollowedList.new
      end
    
      # GET /followed_lists/1/edit
      def edit
      end
    
      # POST /followed_lists or /followed_lists.json
      def create
        @followed_list = FollowedList.new(followed_list_params)
    
        respond_to do |format|
          if @followed_list.save
            format.html { redirect_to followed_list_url(@followed_list), notice: "Followed list was successfully created." }
            format.json { render :show, status: :created, location: @followed_list }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @followerailsd_list.errors, status: :unprocessable_entity }
          end
        end
      end
    
      # PATCH/PUT /followed_lists/1 or /followed_lists/1.json
      def update
        respond_to do |format|
          if @followed_list.update(followed_list_params)
            format.html { redirect_to followed_list_url(@followed_list), notice: "Followed list was successfully updated." }
            format.json { render :show, status: :ok, location: @followed_list }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @followed_list.errors, status: :unprocessable_entity }
          end
        end
      end
    
      # DELETE /followed_lists/1 or /followed_lists/1.json
      def destroy
        @followed_list.destroy
    
        respond_to do |format|
          format.html { redirect_to followed_lists_url, notice: "Followed list was successfully destroyed." }
          format.json { head :no_content }
        end
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_followed_list
          @followed_list = FollowedList.find(params[:id])
        end
    
        # Only allow a list of trusted parameters through.
        def followed_list_params
          params.require(:followed_list).permit(:user_id, :list_id)
        end
    end
  end
end