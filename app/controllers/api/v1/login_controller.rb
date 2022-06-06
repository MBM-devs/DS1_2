module Api
  module V1    
    class LoginController < ApplicationController
      skip_before_action :verify_authenticity_token
      # No hace falta, ya que la acción home solo renderiza la página.
      def home
        if session[:user_id] == nil
          redirect_to login_path
        end
      end

      # No hace falta, ya que la acción login solo renderiza la página.
      def login
      end

      # Crea una sesion
      def create
        puts params
        @user = User.find_by(username: params[:username])
        
        respond_to do |format|
            # Se comprueba la contraseña con la del usuario de la base de datos
          if !!@user && @user.authenticate(params[:password])
            # Si es correcta se crea la sesion y se reditige
            format.json { render 'users/show', status: :ok, location: @user }
          else
            # si no es correcta mostramos un mensaje de error
            message = {"error": "Error usuario o contraseña incorrectos."}
            format.json { render json: message }
          end
          
        end
        
      end

      def destroy    
        session[:user_id] = nil         
        redirect_to root_path 
      end  
    end
  end
end