class SessionController < ApplicationController
  # No hace falta, ya que la acción home solo renderiza la página.
  def home
  end

  # No hace falta, ya que la acción login solo renderiza la página.
  def login
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
    User.find(session[:user_id]).destroy      
    session[:user_id] = nil         
    redirect_to root_path 
  end  
end
