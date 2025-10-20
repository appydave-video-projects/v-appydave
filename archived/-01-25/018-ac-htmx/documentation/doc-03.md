n 1s ;
}
When htmx swaps in this new content, it will do so in such a way that the CSS transition will apply to the new content, giving you a nice, smooth transition to the new state.

So, in summary, all you need to do to use CSS transitions for an element is keep its id stable across requests!

You can see the Animation Examples for more details and live demonstrations.

🔗Details
To understand how CSS transitions actually work in htmx, you must understand the underlying swap & settle model that htmx uses.

When new content is received from a server, before the content is swapped in, the existing content of the page is examined for elements that match by the id attribute. If a match is found for an element in the new content, the attributes of the old content are copied onto the new element before the swap occurs. The new content is then swapped in, but with the old attribute values. Finally, the new attribute values are swapped in, after a “settle” delay (20ms by default). A little crazy, but this is what allowes CSS transitions to work without any javascript by the developer.

🔗Out of Band Swaps
If you want to swap content from a response directly into the DOM by using the id attribute you can use the hx-swap-oob attribute in the response html:

<div id="message" hx-swap-oob="true">Swap me directly!</div>
Additional Content
In this response, div#message would be swapped directly into the matching DOM element, while the additional content would be swapped into the target in the normal manner.

You can use this technique to “piggy-back” updates on other requests.

Note that out of band elements must be in the top level of the response, and not children of the top level elements.

🔗Selecting Content To Swap
If you want to select a subset of the response HTML to swap into the target, you can use the hx-select attribute, which takes a CSS selector and selects the matching elements from the response.

You can also pick out pieces of content for an out-of-band swap by using the hx-select-oob attribute, which takes a list of element IDs to pick out and swap.

🔗Preserving Content During A Swap
If there is content that you wish to be preserved across swaps (e.g. a video player that you wish to remain playing even if a swap occurs) you can use the hx-preserve attribute on the elements you wish to be preserved.

🔗Parameters
By default, an element that causes a request will include its value if it has one. If the element is a form it will include the values of all inputs within it.

As with HTML forms, the name attribute of the input is used as the parameter name in the request that htmx sends.

Additionally, if the element causes a non-GET request, the values of all the inputs of the nearest enclosing form will be included.

If you wish to include the values of other elements, you can use the hx-include attribute with a CSS selector of all the elements whose values you want to include in the request.

If you wish to filter out some parameters you can use the hx-params attribute.

Finally, if you want to programatically modify the parameters, you can use the htmx:configRequest event.

🔗File Upload
If you wish to upload files via an htmx request, you can set the hx-encoding attribute to multipart/form-data. This will use a FormData object to submit the request, which will properly include the file in the request.

Note that depending on your server-side technology, you may have to handle requests with this type of body content very differently.

Note that htmx fires a htmx:xhr:progress event periodically based on the standard progress event during upload, which you can hook into to show the progress of the upload.

You can include extra values in a request using the hx-vals (name-expression pairs in JSON format) and hx-vars attributes (comma-separated name-expression pairs that are dynamically computed).

🔗Confirming Requests
Often you will want to confirm an action before issuing a request. htmx supports the hx-confirm attribute, which allows you to confirm an action using a simple javascript dialog:

<button hx-delete="/account" hx-confirm="Are you sure you wish to delete your account?">
 Delete My Account
</button>
Using events you can implement more sophisticated confirmation dialogs. The confirm example shows how to use sweetalert2 library for confirmation of htmx actions.

🔗Attribute Inheritance
Most attributes in htmx are inherited: they apply to the element they are on as well as any children elements. This allows you to “hoist” attributes up the DOM to avoid code duplication. Consider the following htmx:

<button hx-delete="/account" hx-confirm="Are you sure?">
 Delete My Account
</button>
<button hx-put="/account" hx-confirm="Are you sure?">
 Update My Account
</button>
Here we have a duplicate hx-confirm attribute. We can hoist this attribute to a parent element:

<div hx-confirm="Are you sure?">
 <button hx-delete="/account">
 Delete My Account
 </button>
 <button hx-put="/account">
 Update My Account
 </button>
</div>
This hx-confirm attribute will now apply to all htmx-powered elements within it.

Sometimes you wish to undo this inheritance. Consider if we had a cancel button to this group, but didn’t want it to be confirmed. We could add an unset directive on it like so:

<div hx-confirm="Are you sure?">
 <button hx-delete="/account">
 Delete My Account
 </button>
 <button hx-put="/account">
 Update My Account
 </button>
 <button hx-confirm="unset" hx-get="/">
 Cancel
 </button>
</div>
The top two buttons would then show a confirm dialog, but the bottom cancel button would not.

Automatic inheritance can be disabled using the hx-disinherit attribute.

🔗Boosting
Htmx supports “boosting” regular HTML anchors and forms with the hx-boost attribute. This attribute will convert all anchor tags and forms into AJAX requests that, by default, target the body of the page.

Here is an example:

<div hx-boost="true">
 <a href="/blog">Blog</a>
</div>
The anchor tag in this div will issue an AJAX GET request to /blog and swap the response into the body tag.

🔗Progressive Enhancement
A feature of hx-boost is that it degrades gracefully if javascript is not enabled: the links and forms continue to work, they simply don’t use ajax requests. This is known as Progressive Enhancement, and it allows a wider audience to use your sites functionality.

Other htmx patterns can be adapted to achieve progressive enhancement as well, but they will require more thought.

Consider the active search example. As it is written, it will not degrade gracefully: someone who does not have javascript enabled will not be able to use this feature. This is done for simplicity’s sake, to keep the example as brief as possible.

However, you could wrap the htmx-enhanced input in a form element:

<form action="/search" method="POST">
 <input class="form-control" type="search"  name="search" placeholder="Begin typing to search users..."  hx-post="/search"  hx-trigger="keyup changed delay:500ms, search"  hx-target="#search-results"  hx-indicator=".htmx-indicator"
 >
</form>
With this in place, javascript-enabled clients would still get the nice active-search UX, but non-javascript enabled clients would be able to hit the enter key and still search. Even better, you could add a “Search” button as well. You would then need to update the form with an hx-post that mirrored the action attribute, or perhaps use hx-boost on it.

You would need to check on the server side for the HX-Request header to differentiate between an htmx-driven and a regular request, to determine exactly what to render to the client.

Other patterns can be adapted similarly to achieve the progressive enhancement needs of your application.

As you can see, this requires more thought and more work. It also rules some functionality entirely out of bounds. These tradeoffs must be made by you, the developer, with respect to your projects goals and audience.

Accessibility is a concept closely related to progressive en