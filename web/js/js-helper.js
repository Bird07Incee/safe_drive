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

function setStrictlyNecessaryCookie(cookieName, cookieValue, expirationDays) {
  var expirationDate = new Date();
  expirationDate.setTime(expirationDate.getTime() + (expirationDays * 24 * 60 * 60 * 1000));
  var expires = "expires=" + expirationDate.toUTCString();
  document.cookie = encodeURIComponent(cookieName) + "=" + encodeURIComponent(cookieValue) + "; " + expires + "; path=/";
}