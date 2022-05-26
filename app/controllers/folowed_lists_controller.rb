class FolowedListsController < ApplicationController
  before_action :set_folowed_list, only: %i[ show edit update destroy ]

  # GET /folowed_lists or /folowed_lists.json
  def index
    @folowed_lists = FolowedList.all
  end

  # GET /folowed_lists/1 or /folowed_lists/1.json
  def show
  end

  # GET /folowed_lists/new
  def new
    @folowed_list = FolowedList.new
  end

  # GET /folowed_lists/1/edit
  def edit
  end

  # POST /folowed_lists or /folowed_lists.json
  def create
    @folowed_list = FolowedList.new(folowed_list_params)

    respond_to do |format|
      if @folowed_list.save
        format.html { redirect_to folowed_list_url(@folowed_list), notice: "Folowed list was successfully created." }
        format.json { render :show, status: :created, location: @folowed_list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @folowed_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /folowed_lists/1 or /folowed_lists/1.json
  def update
    respond_to do |format|
      if @folowed_list.update(folowed_list_params)
        format.html { redirect_to folowed_list_url(@folowed_list), notice: "Folowed list was successfully updated." }
        format.json { render :show, status: :ok, location: @folowed_list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @folowed_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folowed_lists/1 or /folowed_lists/1.json
  def destroy
    @folowed_list.destroy

    respond_to do |format|
      format.html { redirect_to folowed_lists_url, notice: "Folowed list was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folowed_list
      @folowed_list = FolowedList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def folowed_list_params
      params.require(:folowed_list).permit(:user_id, :list_id)
    end
end
