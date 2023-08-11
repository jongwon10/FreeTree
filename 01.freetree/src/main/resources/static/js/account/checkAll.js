function checkAllm() {
    var checkboxes = document.getElementsByName("mterms");
    var checkAllCheckbox = checkboxes[0];

    for (var i = 1; i < checkboxes.length; i++) {
        checkboxes[i].checked = checkAllCheckbox.checked;
    }
}

function checkAllc() {
    var checkboxes = document.getElementsByName("cterms");
    var checkAllCheckbox = checkboxes[0];

    for (var i = 1; i < checkboxes.length; i++) {
        checkboxes[i].checked = checkAllCheckbox.checked;
    }
}

