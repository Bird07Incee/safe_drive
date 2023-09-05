function loadOneTrustCookieScript() {
    let script1 = document.createElement('script');
    script1.type = "text/javascript";
    script1.src = "https://cdn-apac.onetrust.com/consent/7906433a-6655-46cf-b306-d14c84ce29b3-test/OtAutoBlock.js";
    document.body.appendChild(script1);

    let script2 = document.createElement('script');
    script2.type = "text/javascript";
    script2.src = "https://cdn-apac.onetrust.com/scripttemplates/otSDKStub.js";
    script2.setAttribute("charset", "UTF-8");
    script2.setAttribute("data-document-language", "true");
    script2.setAttribute("data-domain-script", "7906433a-6655-46cf-b306-d14c84ce29b3-test");
    document.body.appendChild(script2);
}