module ApplicationHelper

    # Devuelve si hay o no una sesión activa
    def logged_in? 
        !!session[:user_id]
    end

    # Devuelve el modelo de la Base de datos correspondiente con el usuario actual.
    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if !!session[:user_id]
    end


    def recipes_from_list(list_id)
        recipes_list = RecipesList.where(list_id: list_id)
        @recipes_ids = []
        for id in recipes_list do
          @recipes_ids.push(id.recipe_id)
        end
        return Recipe.where("recipes.id IN (?)", @recipes_ids)
    end

    def follower_from_user(user_id)
        followers_list = Following.where(followed: user_id)
        @followers_ids = []
        for id in followers_list do
          @followers_ids.push(id.follower)
        end
       return User.where("users.id IN (?)", @followers_ids)
    end

    def followed_from_user(user_id)
        followed_list = Following.where(follower: user_id)
        @followed_ids = []
        for id in followed_list do
            @followed_ids.push(id.followed)
        end
        return User.where("users.id IN (?)", @followed_ids)
    end

    def lists_from_user(user_id)
        return List.where(user_id: user_id)  
    end

    def rating_from_recipe(recipe_id)
        @rating = 0.0;
        ratings = Rating.where(recipe_id: recipe_id)
        if(ratings.count > 0)
            for entry in ratings do
                @rating += entry.rating
            end
            @rating /= ratings.count
        end
        return @rating
    end

    def rating_from_list(list)
        recetas = recipes_from_list(list)
        @rating = 0.0;
        if(recetas.count > 0)
            for receta in recetas do
                @rating += rating_from_recipe(receta);
            end
            @rating /= recetas.count
        end
        return @rating
    end
end
