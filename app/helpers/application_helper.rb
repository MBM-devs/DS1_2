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

    def user_related_lists(user_id)
        listas_usuario = List.where(user_id: user_id)
        listas_seguidas = FollowedList.where(user_id: user_id)

        id_listas = []

        for lista in listas_usuario do
            id_listas.push(lista.id)
        end

        for lista in listas_seguidas do
            id_listas.push(lista.list_id)
        end

        return List.where("id IN (?)", id_listas)
    end

    def is_my_list?(user_id, list_id)
        is_my_list = List.find_by(user_id: user_id, id: list_id);
        return is_my_list != nil
    end

    def is_following_list?(user_id, list_id)
        is_following_list = FollowedList.find_by(user_id: user_id, list_id: list_id);
        return is_following_list != nil
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

    def is_following?(id, id_follower)
        is_following = Following.find_by(follower: id, followed: id_follower)
        return is_following != nil
    end

    def posts_from_user(user_id)
        return Posts.where(user_id: user_id)
    end

    def post_type(post)
        type = nil
        if(post.recipe_id != nil)
            if(post.list_id != nil)
                type = "recipe_to_list"
            else
                type = "new_recipe"
            end
        elsif(post.list_id != nil) 
            type = "new_list"
        else
            type = "follow"
        end
        return type
    end

    def posts_from_followings(user_id)
        followings = Following.where(follower: user_id)
        @followings_ids = []
        for id in followings do
            @followings_ids.push(id.followed)
        end
        return Post.where("posts.user_id IN (?)", @followings_ids).order("created_at DESC")
    end

    def username(user_id)
        return User.find_by_id(user_id).username
    end

    def recipe(id)
        return Recipe.find_by_id(id)
    end

    def lista(id)
        List.find_by_id(id)
    end

end
