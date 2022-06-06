// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

var sliders = ["slider-listas", "slider-recetas", "slider-siguiendo", "slider-seguidores"]

window.onload = () => {
    document.getElementById("link-listas").addEventListener("click", showListas);
    document.getElementById("link-recetas").addEventListener("click", showRecetas);
    document.getElementById("link-siguiendo").addEventListener("click", showSiguiendo);
    document.getElementById("link-seguidores").addEventListener("click", showSeguidores);
}

function showSlider(id) {
    hideSliders();
    document.getElementById(id).style.display = "block";
}

function hideSliders() {
    sliders.forEach(id => {
        document.getElementById(id).style.display = "none";
    });
}

function showListas() {
    showSlider("slider-listas");
}

function showRecetas() {
    showSlider("slider-recetas");
}

function showSiguiendo() {
    showSlider("slider-siguiendo");
}

function showSeguidores() {
    showSlider("slider-seguidores");
}