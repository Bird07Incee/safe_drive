function loadOneTrustCookieScript() {
    let script1 = document.createElement('script');
    script1.type = "text/javascript";
    script1.src = "https://cdn-apac.onetrust.com/consent/5304c4a0-db56-49ce-9950-fe9f7ac9aedc-test/OtAutoBlock.js";
    document.body.appendChild(script1);

    let script2 = document.createElement('script');
    script2.type = "text/javascript";
    script2.src = "https://cdn-apac.onetrust.com/scripttemplates/otSDKStub.js";
    script2.setAttribute("charset", "UTF-8");
    script2.setAttribute("data-document-language", "true");
    script2.setAttribute("data-domain-script", "5304c4a0-db56-49ce-9950-fe9f7ac9aedc-test");
    document.body.appendChild(script2);
}

function hideOneTrustCookieScript() {
    try {
        const onetrust = document.getElementById("onetrust-consent-sdk");
        onetrust.setAttribute("style", "visibility: hidden;");
    } catch {
        console.log("onetrust hide error");
    }
}

function showOneTrustCookieScript() {
    try {
        const onetrust = document.getElementById("onetrust-consent-sdk");
        onetrust.setAttribute("style", "visibility: visible;");
    } catch {
        console.log("onetrust show error");
    }
}