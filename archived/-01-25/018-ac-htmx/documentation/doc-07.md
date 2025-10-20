 = !show_new">Toggle New Content</button>
 <template x-if="show_new">
 <div id="new_content">
 <a hx-get="/server/newstuff" href="#">New Clickable</a>
 </div>
 </template>
</div>
🔗Caching
htmx works with standard HTTP caching mechanisms out of the box.

If your server adds the Last-Modified HTTP response header to the response for a given URL, the browser will automatically add the If-Modified-Since request HTTP header to the next requests to the same URL. Be mindful that if your server can render different content for the same URL depending on some other headers, you need to use the Vary response HTTP header. For example, if your server renders the full HTML when the HX-Request header is missing or false, and it renders a fragment of that HTML when HX-Request: true, you need to add Vary: HX-Request. That causes the cache to be keyed based on a composite of the response URL and the HX-Request request header — rather than being based just on the response URL.

If you are unable (or unwilling) to use the Vary header, you can alternatively set the configuration parameter getCacheBusterParam to true. If this configuration variable is set, htmx will include a cache-busting parameter in GET requests that it makes, which will prevent browsers from caching htmx-based and non-htmx based responses in the same cache slot.

htmx also works with ETag as expected. Be mindful that if your server can render different content for the same URL (for example, depending on the value of the HX-Request header), the server needs to generate a different ETag for each content.

🔗Security
htmx allows you to define logic directly in your DOM. This has a number of advantages, the largest being Locality of Behavior making your system more coherent.

One concern with this approach, however, is security. This is especially the case if you are injecting user-created content into your site without any sort of HTML escaping discipline.

You should, of course, escape all 3rd party untrusted content that is injected into your site to prevent, among other issues, XSS attacks. Attributes starting with hx- and data-hx, as well as inline <script> tags should be filtered.

It is important to understand that htmx does not require inline scripts or eval() for most of its features. You (or your security team) may use a CSP that intentionally disallows inline scripts and the use of eval(). This, however, will have no effect on htmx functionality, which will still be able to execute JavaScript code placed in htmx attributes and may be a security concern. With that said, if your site relies on inline scripts that you do wish to allow and have a CSP in place, you may need to define htmx.config.inlineScriptNonce–however, HTMX will add this nonce to all inline script tags it encounters, meaning a nonce-based CSP will no longer be effective for HTMX-loaded content.

To address this, if you don’t want a particular part of the DOM to allow for htmx functionality, you can place the hx-disable or data-hx-disable attribute on the enclosing element of that area.

This will prevent htmx from executing within that area in the DOM:

<div hx-disable>
 <%= user_content %>
</div>
This approach allows you to enjoy the benefits of Locality of Behavior while still providing additional safety if your HTML-escaping discipline fails.

🔗Configuring htmx
Htmx has some configuration options that can be accessed either programatically or declaratively. They are listed below:

You can set them directly in javascript, or you can use a meta tag:

<meta name="htmx-config" content='{"defaultSwapStyle":"outerHTML"}'>
🔗Conclusion
And that’s it!

Have fun with htmx! You can accomplish quite a bit without writing a lot of code!


 
