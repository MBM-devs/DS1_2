class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
    @user = User.find(params[:id])      
    @mis_recetas = List.find_by(user_id: @user.id, name: "Mis Recetas")
    # url = URI("https://clados.ugr.es/DS1_2/api/v1/users/#{params[:id]}")
    # result = Net::HTTP.get(url)
    # result = JSON.parse(result)
    # @user = User.user_from_api(result)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
  end

  # POST /users or /users.json
  def create
    # uri = URI('https://clados.ugr.es/DS1_2/api/v1/users')
    # puts user_params
 
    # request = Net::HTTP.post_form(uri, user_params.to_hash)
    # request.body = user_params
    # puts request.body
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id # establece la sesión
        List.create(name: "Recetas de #{@user.username}", user_id:@user.id);
        List.create(name: "Recetas Guardadas", user_id:@user.id);
        # format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.html { redirect_to root_path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }

      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    if session[:user_id] == nil || User.find_by_id(session[:user_id]).username != "admin"
      redirect_to root_path
    end
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
