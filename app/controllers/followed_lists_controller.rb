class FollowedListsController < ApplicationController
  before_action :set_followed_list, only: %i[ show edit update destroy ]

  # GET /followed_lists or /followed_lists.json
  def index
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
    @followed_lists = FollowedList.all
  end

  # GET /followed_lists/1 or /followed_lists/1.json
  def show
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
  end

  # GET /followed_lists/new
  def new
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
    @followed_list = FollowedList.new
  end

  # GET /followed_lists/1/edit
  def edit
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
  end

  # POST /followed_lists or /followed_lists.json
  def create
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
    @followed_list = FollowedList.new(followed_list_params)

    respond_to do |format|
      if @followed_list.save
        format.html { redirect_to followed_list_url(@followed_list), notice: "Followed list was successfully created." }
        format.json { render :show, status: :created, location: @followed_list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @followed_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /followed_lists/1 or /followed_lists/1.json
  def update
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
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
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
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
