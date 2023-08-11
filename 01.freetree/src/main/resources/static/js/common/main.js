
window.onload = function(){
    setTimeout(function (){
        scrollTo(0, 0);
    }, 100);
}



window.addEventListener("DOMContentLoaded", function(){

    var section1 = document.getElementById('slide');
    var imgWrap1 = document.getElementById('slide_next_button');
    var imgWrap2 = document.getElementById('slide_prev_button');

    var slideWidth = section_1.offsetWidth; // ction_1의 너비se

    var currentPosition = 0;
    var isSliding = false;
    var $dot = $("#dot-list li");
    var slideIndex = 0;




    function slideLeft() {
        if (!isSliding && currentPosition > -slideWidth) {
            isSliding = true;
            currentPosition -= slideWidth;
            section1.style.transform = 'translateX(' + -50 + '%)';
            setTimeout(function() {
                isSliding = false;
            }, 500); // 애니메이션 시간(0.5초) 후에 슬라이딩 상태 초기화
        }

        $("#on1").removeClass('on');
        $("#on2").addClass('on');

        $dot.off().on("click", function() {
            var dotIndex = $(this).index();
            slideTo(dotIndex);
            $dot.removeClass("on");
            $(this).addClass("on")
        });

    }


    function slideRight() {
        if (!isSliding && currentPosition < 0) {
            isSliding = true;
            currentPosition += slideWidth;
            section1.style.transform = 'translateX(' + 0 + '%)';
            setTimeout(function() {
                isSliding = false;
            }, 500); // 애니메이션 시간(0.5초) 후에 슬라이딩 상태 초기화
        }

        $("#on2").removeClass('on');
        $("#on1").addClass('on');

        $dot.off().on("click", function() {
            var dotIndex = $(this).index();
            slideTo(dotIndex);
            $dot.removeClass("on");
            $(this).addClass("on");
        });

    }


    imgWrap1.addEventListener('click', slideLeft);
    imgWrap2.addEventListener('click', slideRight);



    function slideTo(index){
        if (!isSliding && index >= 0 && index < $dot.length) {
            isSliding = true;
            currentPosition = -slideWidth * index;
            section1.style.transform = 'translateX(' + currentPosition + 'px)';
            $dot.removeClass('active');
            $dot.eq(index).addClass('active');
            slideIndex = index;
            setTimeout(function(){
                isSliding = false;
            },500);
        }
    }


    $dot.off().on("click", function() {
        var dotIndex = $(this).index();
        slideTo(dotIndex);
        $dot.removeClass("on");
        $(this).addClass("on");
    });

});







































