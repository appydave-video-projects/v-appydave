htmx is a library that allows you to access modern browser features directly from HTML, rather than using javascript.

To understand htmx, first lets take a look at an anchor tag:

<a href="/blog">Blog</a>
This anchor tag tells a browser:

“When a user clicks on this link, issue an HTTP GET request to ‘/blog’ and load the response content into the browser window”.

With that in mind, consider the following bit of HTML:

<button hx-post="/clicked"
 hx-trigger="click"
 hx-target="#parent-div"
 hx-swap="outerHTML"
>
 Click Me!
</button>
This tells htmx:

“When a user clicks on this button, issue an HTTP POST request to ‘/clicked’ and use the content from the response to replace the element with the id parent-div in the DOM”

htmx extends and generalizes the core idea of HTML as a hypertext, opening up many more possibilities directly within the language:

Now any element, not just anchors and forms, can issue an HTTP request
Now any event, not just clicks or form submissions, can trigger requests
Now any HTTP verb, not just GET and POST, can be used
Now any element, not just the entire window, can be the target for update by the request
Note that when you are using htmx, on the server side you typically respond with HTML, not JSON. This keeps you firmly within the original web programming model, using Hypertext As The Engine Of Application State without even needing to really understand that concept.

It’s worth mentioning that, if you prefer, you can use the data- prefix when using htmx:

<a data-hx-post="/click">Click Me!</a>
🔗Installing
Htmx is a dependency-free, browser-oriented javascript library. This means that using it is as simple as adding a <script> tag to your document head. No need for complicated build steps or systems.

If you are migrating to htmx from intercooler.js, please see the migration guide.

🔗Via A CDN (e.g. unpkg.com)
The fastest way to get going with htmx is to load it via a CDN. You can simply add this to your head tag and get going:

<script src="https://unpkg.com/htmx.org@1.9.2" integrity="sha384-L6OqL9pRWyyFU3+/bjdSri+iIphTN/bvYyM37tICVyOJkWZLpP2vGn6VUEXgzg6h" crossorigin="anonymous"></script>
While the CDN approach is extremely simple, you may want to consider not using CDNs in production.

🔗Download a copy
The next easiest way to install htmx is to simply copy it into your project.

Download htmx.min.js from unpkg.com and add it to the appropriate directory in your project and include it where necessary with a <script> tag:

<script src="/path/to/htmx.min.js"></script>
You can also add extensions this way, by downloading them from the ext/ directory.

🔗npm
For npm-style build systems, you can install htmx via npm:

npm install htmx.org
After installing, you’ll need to use appropriate tooling to use node_modules/htmx.org/dist/htmx.js (or .min.js). For example, you might bundle htmx with some extensions and project-specific code.

🔗Webpack
If you are using webpack to manage your javascript:

Install htmx via your favourite package manager (like npm or yarn)
Add the import to your index.js
import 'htmx.org';
If you want to use the global htmx variable (recommended), you need to inject it to the window scope:

Create a custom JS file
Import this file to your index.js (below the import from step 2)
import 'path/to/my_custom.js';
Then add this code to the file:
window.htmx = require('htmx.org');
Finally, rebuild your bundle
🔗AJAX
The core of htmx is a set of attributes that allow you to issue AJAX requests directly from HTML:

Attribute	Description
hx-get	Issues a GET request to the given URL
hx-post	Issues a POST request to the given URL
hx-put	Issues a PUT request to the given URL
hx-patch	Issues a PATCH request to the given URL
hx-delete	Issues a DELETE request to the given URL
Each of these attributes takes a URL to issue an AJAX request to. The element will issue a request of the specified type to the given URL when the element is triggered:

<div hx-put="/messages">
 Put To Messages
</div>
This tells the browser:

When a user clicks on this div, issue a PUT request to the URL /messages and load the response into the div

🔗Triggering Requests
By default, AJAX requests are triggered by the “natural” event of an element:

input, textarea & select are triggered on the change event
form is triggered on the submit event
everything else is triggered by the click event
If you want different behavior you can use the hx-trigger attribute to specify which event will cause the request.

Here is a div that posts to /mouse_entered when a mouse enters it:

<div hx-post="/mouse_entered" hx-trigger="mouseenter">
 [Here Mouse, Mouse!]
</div>
🔗Trigger Modifiers
A trigger can also have a few additional modifiers that change its behavior. For example, if you want a request to only happen once, you can use the once modifier for the trigger:

<div hx-post="/mouse_entered" hx-trigger="mouseenter once">
 [Here Mouse, Mouse!]
</div>
Other modifiers you can use for triggers are:

changed - only issue a request if the value of the element has changed
delay:<time interval> - wait the given amount of time (e.g. 1s) before issuing the request. If the event triggers again, the countdown is reset.
throttle:<time interval> - wait the given amount of time (e.g. 1s) before issuing the request. Unlike delay if a new event occurs before the time limit is hit the event will be discarded, so the request will trigger at the end of the time period.
from:<CSS Selector> - listen for the event on a different element. This can be used for things like keyboard shortcuts.
You can use these attributes to implement many common UX patterns, such as Active Search:

<input type="text" name="q"
 hx-get="/trigger_delay"
 hx-trigger="keyup changed delay:500ms"
 hx-target="#search-results"
 placeholder="Search..."
>
<div id="search-results"></div>
This input will issue a request 500 milliseconds after a key up event if the input has been changed and inserts the results into the div with the id search-results.

Multiple triggers can be specified in the hx-trigger attribute, separated by commas.

🔗Trigger Filters
You may also apply trigger filters by using square brackets after the event name, enclosing a javascript expression that will be evaluated. If the expression evaluates to true the event will trigger, otherwise it will not.

Here is an example that triggers only on a Control-Click of the element

<div hx-get="/clicked" hx-trigger="click[ctrlKey]">
 Control Click Me
</div>
Properties like ctrlKey will be resolved against the triggering event first, then the global scope.

🔗Special Events
htmx provides a few special events for use in hx-trigger:

load - fires once when the element is first loaded
revealed - fires once when an element first scrolls into the viewport
intersect - fires once when an element first intersects the viewport. This supports two additional options:
root:<selector> - a CSS selector of the root element for intersection
threshold:<float> - a floating point number between 0.0 and 1.0, indicating what amount of intersection to fire the event on
You can also use custom events to trigger requests if you have an advanced use case.

🔗Polling
If you want an element to poll the given URL rather than wait for an event, you can use the every syntax with the hx-trigger attribute:

<div hx-get="/news" hx-trigger="every 2s"></div>
This tells htmx

Every 2 seconds, issue a GET to /news and load the response into the div

If you want to stop polling from a server response you can respond with the HTTP response code 286 and the element will cancel the polling.

🔗Load Polling
Another technique that can be used to achieve polling in htmx is “load polling”, where an element specifies a load trigger along with a delay, and replaces itself with the response:

<div hx-get="/messages"
 hx-trigger="load delay:1s"
 hx-swap="outerHTML"
>
</div>
If the /messages end point keeps returning a div set up this way, it will keep “polling” back to the URL every second.

Lo