class FollowingsController < ApplicationController
  skip_before_action :verify_authenticity_token
  # before_action :set_following, only: %i[ show edit update destroy ]

  # GET /followings or /followings.json
  def index
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
    @followings = Following.all
  end

  # GET /followings/1 or /followings/1.json
  def show
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
  end

  # GET /followings/new
  def new
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
    @following = Following.new
  end

  # GET /followings/1/edit
  def edit
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
  end

  # POST /followings or /followings.json
  def create
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
    @following = Following.new(following_params)

    respond_to do |format|
      if @following.save
        Post.create(user_id: following_params[:follower], following_id: following_params[:followed])
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
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
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
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
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
