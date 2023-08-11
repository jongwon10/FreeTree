
window.onload = function(){
    setTimeout(function (){
        scrollTo(0, 0);
    }, 100);
}



function toggleContent() {
    var slideMenu = document.getElementById('hiddenList');

    if (slideMenu.style.height === '0px' || slideMenu.style.height === '') {
        slideMenu.style.height = '150px';
    } else {
        slideMenu.style.height = '0px';
    }
}

