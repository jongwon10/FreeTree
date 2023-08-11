function toggleHiddenContent(contentId) {
    const hiddenContent = document.getElementById(`hiddenContent${contentId}`);
    hiddenContent.classList.toggle('hidden');

    if (hiddenContent.classList.contains('hidden')) {
        hiddenContent.querySelector('p').style.textAlign = '';
    } else {
        hiddenContent.querySelector('p').style.textAlign = 'center';
    }
}