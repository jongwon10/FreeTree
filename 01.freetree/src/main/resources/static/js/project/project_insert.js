
// 프로젝트명 클릭 이벤트
document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.querySelector('.name-i');

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

// 프로젝트 예상 기간 클릭 이벤트
document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.querySelector('.when-insert');

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


document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.querySelector('.name-i');
    var characterCount = document.querySelector('.count');

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



// 프로젝트 기간 길이 2로 설정
document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.querySelector('.when-insert');

    nameInput.addEventListener('input', function() {
        var count = nameInput.value.length; // Get the number of entered characters

        if (count > 2) {
            nameInput.value = nameInput.value.slice(0, 2); // Limit the input to two characters
        }
    });
});

// 프로젝트 예산 길이 9로 설정
document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.querySelector('.min-money');

    nameInput.addEventListener('input', function() {
        var count = nameInput.value.length; // Get the number of entered characters

        if (count > 9) {
            nameInput.value = nameInput.value.slice(0, 9); // Limit the input to two characters
        }
    });
});

// 프로젝트 예산 길이 9로 설정
document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.querySelector('.max-money');

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


// 스킬 추가/ 빼기
function addSkill() {
    const skillBar = document.querySelector('.skill-bar');
    const selectedSkill = skillBar.value;
    const skillInsertBox = document.querySelector('.skill-insert-box');
    let skillValues = skillInsertBox.value.split(',').map(skill => skill.trim());

    if (selectedSkill === "요구 스킬*") {
        return; // 선택된 스킬이 "요구 스킬*"인 경우 아무 작업도 수행하지 않음
    }

    // 이미 선택된 스킬이 스킬 입력 상자에 있는 경우 제거
    if (skillValues.includes(selectedSkill)) {
        skillValues = skillValues.filter(skill => skill !== selectedSkill);
    } else {
        skillValues.push(selectedSkill);
    }

    skillInsertBox.value = skillValues.filter(skill => skill !== '').join(', ');
}

// 필요 인력 제한
document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.querySelector('.people-count');

    nameInput.addEventListener('input', function() {
        var count = nameInput.value.length; // Get the number of entered characters

        if (count > 3) {
            nameInput.value = nameInput.value.slice(0, 3); // Limit the input to two characters
        }
    });
});

// 년차 제한
document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.querySelector('.like-year');

    nameInput.addEventListener('input', function() {
        var count = nameInput.value.length; // Get the number of entered characters

        if (count > 3) {
            nameInput.value = nameInput.value.slice(0, 3); // Limit the input to two characters
        }
    });
});

// 필요인력 클릭이벤트
document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.querySelector('.people-count');

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

// 희망연차 클릭 이벤트
document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.querySelector('.like-year');

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

// 팀소개 텍스트 이벤트
document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.querySelector('.team-text');

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

// 주요업무 텍스트 이벤트
document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.querySelector('.main-work-text');

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

// 지원조건 텍스트 이벤트
document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.querySelector('.support-text');

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

// 우대조건 텍스트 이벤트
document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.querySelector('.condition-text');

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

// 혜택 및 복지 텍스트 이벤트
document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.querySelector('.benefit-text');

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


// 버튼 클릭 이벤트 핸들러 함수
function setPresideValue(value) {
    document.getElementById("preside").value = value;
}