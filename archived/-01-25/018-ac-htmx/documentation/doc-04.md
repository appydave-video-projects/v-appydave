Using progressive enhancement techniques such as hx-boost will make your htmx application more accessible to a wide array of users.

htmx-based applications are very similar to normal, non-AJAX driven web applications because htmx is HTML-oriented.

As such, the normal HTML accessibility recommendations apply. For example:

Use semantic HTML as much as possible (i.e. the right tags for the right things)
Ensure focus state is clearly visible
Associate text labels with all form fields
Maximize the readability of your application with appropriate fonts, contrast, etc.
🔗Web Sockets & SSE
htmx has experimental support for declarative use of both WebSockets and Server Sent Events.

Note: In htmx 2.0, these features will be migrated to extensions. These new extensions are already available in htmx 1.7+ and, if you are writing new code, you are encouraged to use the extensions instead. All new feature work for both SSE and web sockets will be done in the extensions.

Please visit the SSE extension and WebSocket extension pages to learn more about the new extensions.

🔗WebSockets
If you wish to establish a WebSocket connection in htmx, you use the hx-ws attribute:

<div hx-ws="connect:wss:/chatroom">
 <div id="chat_room">
 ...
 </div>
 <form hx-ws="send:submit">
 <input name="chat_message">
 </form>
</div>
The connect declaration established the connection, and the send declaration tells the form to submit values to the socket on submit.

More details can be found on the hx-ws attribute page

🔗Server Sent Events
Server Sent Events are a way for servers to send events to browsers. It provides a higher-level mechanism for communication between the server and the browser than websockets.

If you want an element to respond to a Server Sent Event via htmx, you need to do two things:

Define an SSE source. To do this, add a hx-sse attribute on a parent element with a connect <url> declaration that specifies the URL from which Server Sent Events will be received.

Define elements that are descendents of this element that are triggered by server sent events using the hx-trigger="sse:<event_name>" syntax

Here is an example:

<body hx-sse="connect:/news_updates">
 <div hx-trigger="sse:new_news" hx-get="/news"></div>
</body>
Depending on your implementation, this may be more efficient than the polling example above since the server would notify the div if there was new news to get, rather than the steady requests that a poll causes.

🔗History Support
Htmx provides a simple mechanism for interacting with the browser history API:

If you want a given element to push its request URL into the browser navigation bar and add the current state of the page to the browser’s history, include the hx-push-url attribute:

<a hx-get="/blog" hx-push-url="true">Blog</a>
When a user clicks on this link, htmx will snapshot the current DOM and store it before it makes a request to /blog. It then does the swap and pushes a new location onto the history stack.

When a user hits the back button, htmx will retrieve the old content from storage and swap it back into the target, simulating “going back” to the previous state. If the location is not found in the cache, htmx will make an ajax request to the given URL, with the header HX-History-Restore-Request set to true, and expects back the HTML needed for the entire page. Alternatively, if the htmx.config.refreshOnHistoryMiss config variable is set to true, it will issue a hard browser refresh.

NOTE: If you push a URL into the history, you must be able to navigate to that URL and get a full page back! A user could copy and paste the URL into an email, or new tab. Additionally, htmx will need the entire page when restoring history if the page is not in the history cache.

🔗Specifying History Snapshot Element
By default, htmx will use the body to take and restore the history snapshot from. This is usually the right thing, but if you want to use a narrower element for snapshotting you can use the hx-history-elt attribute to specify a different one.

Careful: this element will need to be on all pages or restoring from history won’t work reliably.

🔗Disabling History Snapshots
History snapshotting can be disabled for a URL by setting the hx-history attribute to false on any element in the current document, or any html fragment loaded into the current document by htmx. This can be used to prevent sensitive data entering the localStorage cache, which can be important for shared-use / public computers. History navigation will work as expected, but on restoration the URL will be requested from the server instead of the local history cache.

🔗Requests & Responses
Htmx expects responses to the AJAX requests it makes to be HTML, typically HTML fragments (although a full HTML document, matched with a hx-select tag can be useful too). Htmx will then swap the returned HTML into the document at the target specified and with the swap strategy specified.

Sometimes you might want to do nothing in the swap, but still perhaps trigger a client side event (see below). For this situation you can return a 204 - No Content response code, and htmx will ignore the content of the response.

In the event of an error response from the server (e.g. a 404 or a 501), htmx will trigger the htmx:responseError event, which you can handle.

In the event of a connection error, the htmx:sendError event will be triggered.

🔗CORS
When using htmx in a cross origin context, remember to configure your web server to set Access-Control headers in order for htmx headers to be visible on the client side.

See all the request and response headers that htmx implements.

htmx includes a number of useful headers in requests:

Header	Description
HX-Request	will be set to “true”
HX-Trigger	will be set to the id of the element that triggered the request
HX-Trigger-Name	will be set to the name of the element that triggered the request
HX-Target	will be set to the id of the target element
HX-Prompt	will be set to the value entered by the user when prompted via hx-prompt
htmx supports some htmx-specific response headers:

HX-Push - pushes a new URL into the browser’s address bar
HX-Redirect - triggers a client-side redirect to a new location
HX-Location - triggers a client-side redirect to a new location that acts as a swap
HX-Refresh - if set to “true” the client side will do a full refresh of the page
HX-Trigger - triggers client side events
HX-Trigger-After-Swap - triggers client side events after the swap step
HX-Trigger-After-Settle - triggers client side events after the settle step
For more on the HX-Trigger headers, see HX-Trigger Response Headers.

Submitting a form via htmx has the benefit, that the Post/Redirect/Get Pattern is not needed any more. After successful processing a POST request on the server, you don’t need to return a HTTP 302 (Redirect). You can directly return the new HTML fragment.

🔗Request Order of Operations
The order of operations in a htmx request are:

The element is triggered and begins a request
Values are gathered for the request
The htmx-request class is applied to the appropriate elements
The request is then issued asynchronously via AJAX
Upon getting a response the target element is marked with the htmx-swapping class
An optional swap delay is applied (see the hx-swap attribute)
The actual content swap is done
the htmx-swapping class is removed from the target
the htmx-added class is added to each new piece of content
the htmx-settling class is applied to the target
A settle delay is done (default: 20ms)
The DOM is settled
the htmx-settling class is removed from the target
the htmx-added class is removed from each new piece of content
You can use the htmx-swapping and htmx-settling classes to create CSS transitions between pages.

🔗Validation
Htmx integrates with the HTML5 Validation API and will not issue a request for a form if a validatable input is invalid. This is true for both AJAX requests as well as WebSocket sends.

Htmx fires e