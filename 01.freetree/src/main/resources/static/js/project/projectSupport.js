
// 프로젝트명 클릭 이벤트
document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.querySelector('#name-i');

    nameInput.addEventListener('focus', function() {
        if (nameInput.value === '') {
            nameInput.style.zIndex = '5';
        }
    });

    nameInput.addEventListener('blur', function() {
        if (nameInput.value === '') {
            nameInput.style.zIndex = '';
        }
    });
});




// 프로젝트명 30자 글자 제한
document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.querySelector('#name-i');
    var characterCount = document.querySelector('#count');

    nameInput.addEventListener('input', function() {
        var count = nameInput.value.length; // 입력된 문자 수를 가져옵니다.
        characterCount.textContent = count + '/30'; // 글자 수를 표시합니다.

        if (count > 30) {
            nameInput.value = nameInput.value.slice(0, 29); // 30자로 제한합니다.

        } else {
            characterCount.style.color = 'grey'; // 글자 수가 30자 이하일 때 색상을 기본값으로 변경합니다.
        }
    });

    // 문자 수를 표시할 div 요소를 name-i 입력 필드 옆에 추가합니다.
    nameInput.parentNode.appendChild(characterCount);
});






// 프로젝트 기간 및 예산 숫자만 사용하게 하기
function validateInput(input) {
    input.value = input.value.replace(/[^0-9]/g, '');
}



// 프로젝트 회망급여 길이 최대 9로 설정
document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.querySelector('#ppaymin');

    nameInput.addEventListener('input', function() {
        var count = nameInput.value.length; // Get the number of entered characters

        if (count > 9) {
            nameInput.value = nameInput.value.slice(0, 9); // Limit the input to two characters
        }
    });
});


//  프로젝트 회망급여 길이 최대 9로 설정
document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.querySelector('#ppaymax');

    nameInput.addEventListener('input', function() {
        var count = nameInput.value.length; // Get the number of entered characters

        if (count > 9) {
            nameInput.value = nameInput.value.slice(0, 9); // Limit the input to two characters
        }
    });
});



// 최저금액 단위 z-index늘리기
document.addEventListener('DOMContentLoaded', function() {
    var minMoneyInput = document.querySelector('.min-money');
    var moneyUnit1 = document.querySelector('.money-unit1');

    minMoneyInput.addEventListener('input', function() {
        if (minMoneyInput.value !== '') {
            moneyUnit1.style.zIndex = '5';
        } else {
            moneyUnit1.style.zIndex = '';
        }
    });
});


// 최대금액 단위 z-index늘리기
document.addEventListener('DOMContentLoaded', function() {
    var minMoneyInput = document.querySelector('.max-money');
    var moneyUnit1 = document.querySelector('.money-unit2');

    minMoneyInput.addEventListener('input', function() {
        if (minMoneyInput.value !== '') {
            moneyUnit1.style.zIndex = '5';
        } else {
            moneyUnit1.style.zIndex = '';
        }
    });
});




// 경력 클릭 이벤트
document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.querySelector('#carrer');

    nameInput.addEventListener('focus', function() {
        if (nameInput.value === '') {
            nameInput.style.zIndex = '5';
        }
    });

    nameInput.addEventListener('blur', function() {
        if (nameInput.value === '') {
            nameInput.style.zIndex = '';
        }
    });


});





