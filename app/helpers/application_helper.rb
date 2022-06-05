module ApplicationHelper

    # Devuelve si hay o no una sesión activa
    def logged_in? 
        !!session[:user_id]
    end

    # Devuelve el modelo de la Base de datos correspondiente con el usuario actual.
    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if !!session[:user_id]
    end
end
