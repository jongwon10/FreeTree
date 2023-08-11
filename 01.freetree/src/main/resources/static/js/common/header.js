const hamburger = document.querySelector('.hamburger');

hamburger.addEventListener('click', function() {
    hamburger.classList.toggle('active');
});


function slideload () {
    var slideMenu = document.getElementById('slide_menu');
    var hamburger = document.getElementById('hamburger');

    slideMenu.style.height = '0px';
    hamburger.addEventListener('click', function() {

        if (slideMenu.style.height === '0px') {
            slideMenu.style.height = '200px';
        } else {
            slideMenu.style.height = '0px';
        }
    });
};