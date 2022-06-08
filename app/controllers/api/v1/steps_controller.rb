module Api
  module V1
    class StepsController < ApplicationController
      skip_before_action :verify_authenticity_token
      # before_action :set_step, only: %i[ show edit update destroy ]

      # GET /steps or /steps.json
      def index
        render json: Step.all, status: :ok
      end

      # GET /steps/1 or /steps/1.json
      def show
        @step = Recipe.find_by(id: params[:id])
        if (@step!=nil)
            render json: @step, status: :ok
        else
            render json: :nothing, status: :not_found      
        end
      end

      # GET /steps/new
      def new
        @step = Step.new
      end

      # GET /steps/1/edit
      def edit
      end

      # POST /steps or /steps.json
      def create
        @step = Step.new(step_params)

        respond_to do |format|
          if @step.save
            format.html { redirect_to step_url(@step), notice: "Step was successfully created." }
            format.json { render :show, status: :created, location: @step }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @step.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /steps/1 or /steps/1.json
      def update
        respond_to do |format|
          if @step.update(step_params)
            format.html { redirect_to step_url(@step), notice: "Step was successfully updated." }
            format.json { render :show, status: :ok, location: @step }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @step.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /steps/1 or /steps/1.json
      def destroy
        @step.destroy

        respond_to do |format|
          format.html { redirect_to steps_url, notice: "Step was successfully destroyed." }
          format.json { head :no_content }
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_step
          @step = Step.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def step_params
          params.require(:step).permit(:index, :description, :recipe_id)
        end
    end
  end
end