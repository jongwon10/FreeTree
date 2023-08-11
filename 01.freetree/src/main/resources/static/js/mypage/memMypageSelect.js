function toggleHiddenContent(contentId) {
    const hiddenContent = document.getElementById(`hiddenContent${contentId}`);
    hiddenContent.classList.toggle('hidden');

    if (hiddenContent.classList.contains('hidden')) {
        hiddenContent.querySelector('p').style.textAlign = '';
    } else {
        hiddenContent.querySelector('p').style.textAlign = 'center';
    }
}

$(document).ready(function() {

    $(".project-wrapper").click( function () {
        var container = $(this).parents(".accordion");
        var proj = container.find(".proj-wrapper");
        var trigger = container.find(".material-icons drop");
        var state = container.find(".project-wrapper");

        proj.animate({height: "toggle"}, 100);

        if (trigger.hasClass("icon-expend")) {
            trigger.removeClass("icon-expend");
            // state.removeClass("active");
        }
        else {
            trigger.addClass("icon-expend");
            // state.addClass("active");
        }

        if (container.hasClass("expanded")) {
            container.removeClass("expanded");
        }
        else {
            container.addClass("expanded");
        }
    });
});