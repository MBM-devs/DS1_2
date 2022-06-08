class SessionController < ApplicationController
  include ApplicationHelper
  skip_before_action :verify_authenticity_token
  # No hace falta, ya que la acción home solo renderiza la página.
  def home
    if session[:user_id] == nil
      redirect_to login_path
    else
      
    end
  end

  # No hace falta, ya que la acción login solo renderiza la página.
  def login
  end

  def profile
    if session[:user_id] == nil
      redirect_to login_path
    else
      if(params[:id] != nil)
        @user = User.find_by(id: params[:id])
      else     
        @user = User.find_by(id: session[:user_id])
      end
    
      @mis_recetas = List.find_by(user_id: @user.id, name: "Mis Recetas")
      # redirect_to user_path(session[:user_id])
    end
  end

  # Crea una sesion
  def create
    @user = User.find_by(username: params[:username])
    # Se comprueba la contraseña con la del usuario de la base de datos
    if !!@user && @user.authenticate(params[:password])
      # Si es correcta se crea la sesion y se reditige
      session[:user_id] = @user.id
      redirect_to root_path
    else
      # si no es correcta mostramos un mensaje de error
      message = "Error usuario o contraseña incorrectos."
      redirect_to login_path, notice: message
    end
  end

  def destroy    
    session[:user_id] = nil         
    redirect_to root_path 
  end

  def search
    if session[:user_id] == nil
      redirect_to login_path
    else
      @recipes = Recipe.all
      @lists = List.where.not(name: "Mis Recetas")
    end
  end

  def search_users
    puts ("#{params} AA")
    if(params[:username])
      @users = User.where("username LIKE ?", "%" + params[:username] + "%")
    else
      @users = User.all
    end
    render json: @users, status: :ok
  end

  def search_lists
    if(params[:list])
      @lists = List.where("name LIKE ?", "%" + params[:list] + "%")
    else
      @lists = List.all
    end
    render json: @lists, status: :ok
  end

  def search_recipes
    if(params[:recipe])
      @recipes = Recipe.where("name LIKE ?", "%" + params[:recipe] + "%")
    else
      @recipes = Recipe.all
    end
    render json: @recipes, status: :ok
  end

  def follow
    if(params[:id_current] && params[:id_follow])
      Following.create(follower: params[:id_current], followed: params[:id_follow])
      redirect_to profile_path(:id => params[:id_follow])
    end
  end

  def unfollow
    if(params[:id_current] && params[:id_unfollow])
      row = Following.find_by(follower: params[:id_current], followed: params[:id_unfollow])
      Following.destroy(row.id)
      redirect_to profile_path(:id => params[:id_unfollow])
    end
  end

end
