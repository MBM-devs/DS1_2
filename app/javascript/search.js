window.onload = () => {
    document.getElementById("link-usuarios").addEventListener("click", showSearchUsuarios);
    document.getElementById("link-listas").addEventListener("click", showSearchListas);
    document.getElementById("link-recetas").addEventListener("click", showSearchRecetas);

    document.getElementById("search-usuarios-input").addEventListener("keypress", getUsuarios);
    document.getElementById("search-listas-input").addEventListener("keypress", getListas);
    document.getElementById("search-recetas-input").addEventListener("keypress", getRecetas);
}

var divs = ["search-usuarios-div", "search-listas-div", "search-recetas-div"];
var options = ["link-usuarios", "link-listas", "link-recetas"];
var inputs = ["search-usuarios-input", "search-listas-input", "search-recetas-input"]
var results = ["usuarios-result", "listas-result", "recetas-result"]

function clearInputs() {
    inputs.forEach(id => {
        document.getElementById(id).value = "";
    });
}

function getInputValue(id) {
    return document.getElementById(id).value;
}

function showDiv(id) {
    hideDivs();
    document.getElementById(id).style.display = "block";
}

function hideDivs() {
    divs.forEach(id => {
        document.getElementById(id).style.display = "none";
    });
}

function activateLink(id) {
    clearInputs();
    desactivateLinks();
    document.getElementById(id).style.color = "var(--primary-color)";
}

function desactivateLinks() {
    options.forEach(id => {
        document.getElementById(id).style.color = "black";
    });
}

function showSearchUsuarios() {
    activateLink("link-usuarios");
    showDiv("search-usuarios-div");
}

function showSearchListas() {
    activateLink("link-listas");
    showDiv("search-listas-div");
}

function showSearchRecetas() {
    activateLink("link-recetas");
    showDiv("search-recetas-div");
}

function getUsuarios() {
    if(event.key === "Enter"){
        ul = document.getElementById("usuarios-result").innerHTML = '';
        var url = document.URL + "_users";
    
        var json = {
            username: getInputValue("search-usuarios-input")
        }
    
        var ajax = new XMLHttpRequest();
        ajax.open("POST", url, true);
        ajax.setRequestHeader("Content-Type", "application/json");
        ajax.send(JSON.stringify(json));
    
        console.log(JSON.stringify(json))
    
        ajax.onreadystatechange = function() {
    
            if (this.readyState == 4 && this.status == 200 ) {
                var users = JSON.parse( this.responseText );
                for (var user in users) {
                    addUser(users[user]);
                }
            }
        }
    }
}

function addUser(user) {

    var ul = document.getElementById("usuarios-result");
    
    var div_nombre = document.createElement("div");
    var enlace_nombre = document.createElement("a");
    enlace_nombre.href = getURL() + "profile?id=" + user['id'];
    div_nombre.innerHTML = user['username'];
    enlace_nombre.append(div_nombre);
    
    var wrap_follow_button = document.createElement("div");
    wrap_follow_button.classList.add("wrap-follow-button");
    wrap_follow_button.append(enlace_nombre);
    
    var imagen_perfil = document.createElement("div");
    imagen_perfil.classList.add("imagen-perfil");
    imagen_perfil.innerText = user['username'][0].toUpperCase();
    
    var wrap_imagen_info = document.createElement("div");
    wrap_imagen_info.classList.add("wrap-imagen-info");
    wrap_imagen_info.append(imagen_perfil);
    wrap_imagen_info.append(wrap_follow_button);
    
    var li = document.createElement("li");
    li.append(wrap_imagen_info)

    var wrap_li = document.createElement("div");
    wrap_li.classList.add("wrap-li");
    wrap_li.append(li);

    ul.append(wrap_li);
}

function getListas() {
    if(event.key === "Enter"){
        // ul = document.getElementById("recetas-result").innerHTML = '';
        // var url = document.URL + "_lists";
    
        // var json = {
        //     list: getInputValue("search-listas-input")
        // }
    
        // var ajax = new XMLHttpRequest();
        // ajax.open("POST", url, true);
        // ajax.setRequestHeader("Content-Type", "application/json");
        // ajax.send(JSON.stringify(json));
    
        // console.log(JSON.stringify(json))
    
        // ajax.onreadystatechange = function() {
    
        //     if (this.readyState == 4 && this.status == 200 ) {
        //         var lists = JSON.parse( this.responseText );
        //         for (var i in lists) {
        //             addLista(lists[i]);
        //         }
        //     }
        // }

        var nombres = document.getElementsByClassName('list-name');  
        var ids = document.getElementsByClassName('list-id');  
        for (let i = 0; i < nombres.length; i++){
            if(nombres[i].innerText.toLowerCase().includes(getInputValue("search-listas-input").toLowerCase())){
                var div = document.getElementById(ids[i].innerHTML);
                div.style.display = "block";
            }
            else{
                var div = document.getElementById(ids[i].innerHTML);
                div.style.display = "none";
            }
        }
    }

}

function getRecetas() {
    if(event.key === "Enter"){
        // ul = document.getElementById("recetas-result").innerHTML = '';
        // var url = document.URL + "_recipes";
    
        // var json = {
        //     recipe: getInputValue("search-recetas-input")
        // }
    
        // var ajax = new XMLHttpRequest();
        // ajax.open("POST", url, true);
        // ajax.setRequestHeader("Content-Type", "application/json");
        // ajax.send(JSON.stringify(json));
    
        // console.log(JSON.stringify(json))
    
        // ajax.onreadystatechange = function() {
    
        //     if (this.readyState == 4 && this.status == 200 ) {
        //         var recipes = JSON.parse( this.responseText );
        //         for (var i in recipes) {
        //             addRecipe(recipes[i]);
        //         }
        //     }
        // }
        var ul = document.getElementById("recetas-result");
        var nombres = document.getElementsByClassName('recipe-name');  

        for (let i = 0; i < nombres.length; i++){
            if(nombres[i].innerHTML.toLowerCase().includes(getInputValue("search-recetas-input").toLowerCase())){
                var div = document.getElementById(nombres[i].innerHTML);
                div.style.display = "block";
            }
            else{
                var div = document.getElementById(nombres[i].innerHTML);
                div.style.display = "none";
            }
        }
    }
}

function addRecipe(recipe){
    var ul = document.getElementById("recetas-result");
    
    var div_nombre = document.createElement("div");
    div_nombre.innerHTML = recipe['name'];
    
    var div_num_usuarios = document.createElement("div");
    var icono_people = document.createElement("i");
    icono_people.classList.add("fas", "fa-users");
    div_num_usuarios.append(icono_people);
    div_num_usuarios.innerHTML = " " + recipe['people'];
    
    var div_tiempo = document.createElement("div");
    var icono_tiempo = document.createElement("i");
    icono_tiempo.classList.add("fas", "fa-clock");
    div_tiempo.append(icono_tiempo);
    div_tiempo.innerHTML = " " + recipe['duration'];
    
    var div_valoraciones = document.createElement("div");
    var icono_valoraciones = document.createElement("i");
    icono_valoraciones.classList.add("fas", "fa-star");
    div_valoraciones.append(icono_valoraciones);
    div_valoraciones.innerHTML = " " + recipe['rating'];
    
    var wrap_info = document.createElement("div");
    wrap_info.classList.add("wrap-info");
    wrap_info.append([div_nombre, div_num_usuarios, div_tiempo, div_valoraciones]);
    
    var imagen_li = document.createElement("div");
    imagen_li.classList.add("imagen-li")
    var imagen = document.createElement("img");
    imagen.src = recipe['url_img']
    imagen_li.append(imagen);
    
    var wrap_imagen_info = document.createElement("div");
    wrap_imagen_info.classList.add("wrap-imagen-info");

    var li = document.createElement("li");
    li.append(wrap_imagen_info)

    var wrap_li = document.createElement("div");
    wrap_li.classList.add("wrap-li");
    wrap_li.append(li);

    ul.append(wrap_li);
}

function getURL() {
    var arrayURL = document.URL.split("/");
    var url = "";
    for (let i = 0; i < arrayURL.length - 1; i++) {
        url += arrayURL[i] + '/'
    }

    return url;
}