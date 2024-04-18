function loadOneTrustCookieScript() {
    let script1 = document.createElement('script');
    script1.type = "text/javascript";
    script1.src = "https://cdn-apac.onetrust.com/consent/018ef16a-cf99-7e16-85e4-2ac03c9aed2b/OtAutoBlock.js";
    document.body.appendChild(script1);

    let script2 = document.createElement('script');
    script2.type = "text/javascript";
    script2.src = "https://cdn-apac.onetrust.com/scripttemplates/otSDKStub.js";
    script2.setAttribute("charset", "UTF-8");
    script2.setAttribute("data-document-language", "true");
    script2.setAttribute("data-domain-script", "018ef16a-cf99-7e16-85e4-2ac03c9aed2b");
    document.body.appendChild(script2);
}

function hideOneTrustCookieScript() {
    try {
        const onetrust = document.getElementById("onetrust-consent-sdk");
        onetrust.setAttribute("style", "display: none;");
    } catch {
        console.log("onetrust hide error");
    }
}

function showOneTrustCookieScript() {
    try {
        const onetrust = document.getElementById("onetrust-consent-sdk");
        onetrust.removeAttribute("style");
    } catch {
        console.log("onetrust show error");
    }
}