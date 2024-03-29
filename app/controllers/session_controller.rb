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
    
      @mis_recetas = List.find_by(user_id: @user.id, name: "Recetas de #{@user.username}")
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
      redirect_to request.referer
    end
  end

  def unfollow
    if(params[:id_current] && params[:id_unfollow])
      row = Following.find_by(follower: params[:id_current], followed: params[:id_unfollow])
      Following.destroy(row.id)
      redirect_to request.referer
    end
  end

  def follow_list
    if(params[:id_current] && params[:id_follow])
      FollowedList.create(user_id: params[:id_current], list_id: params[:id_follow])
      redirect_to request.referer
    end
  end

  def unfollow_list
    if(params[:id_current] && params[:id_unfollow])
      row = FollowedList.find_by(user_id: params[:id_current], list_id: params[:id_unfollow])
      FollowedList.destroy(row.id)
      redirect_to request.referer
    end
  end

  def save_recipe
    if(params[:id_user] && params[:id_recipe])
      list = List.find_by(user_id: params[:id_user], name: "Recetas Guardadas")
      RecipesList.create(list_id: list.id, recipe_id: params[:id_recipe])
      redirect_to request.referer
    end
  end

  def unsave_recipe
    if(params[:id_user] && params[:id_recipe])
      list = List.find_by(user_id: params[:id_user], name: "Recetas Guardadas")
      receta_guardada = RecipesList.find_by(list_id: list.id, recipe_id: params[:id_recipe])
      RecipesList.destroy(receta_guardada.id)
      redirect_to request.referer
    end
  end

end
