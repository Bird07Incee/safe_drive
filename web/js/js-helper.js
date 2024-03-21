function jsReload() {
    window.location.reload();
}

function jsAlert(val) {
    alert(val);
}

function callPhone(phoneNumber) {
    window.location.href = "tel:" + phoneNumber;
}

function replacePageHistory() {
    history.pushState(null, null, location.href);
    history.back();
    history.forward();
    window.onpopstate = function () { history.go(1); };
}

function setHistoryToInitialPage() {
    window.location.replace('/');
}