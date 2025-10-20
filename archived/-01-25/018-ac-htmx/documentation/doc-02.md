Load polling can be useful in situations where a poll has an end point at which point the polling terminates, such as when you are showing the user a progress bar.

🔗Request Indicators
When an AJAX request is issued it is often good to let the user know that something is happening since the browser will not give them any feedback. You can accomplish this in htmx by using htmx-indicator class.

The htmx-indicator class is defined so that the opacity of any element with this class is 0 by default, making it invisible but present in the DOM.

When htmx issues a request, it will put a htmx-request class onto an element (either the requesting element or another element, if specified). The htmx-request class will cause a child element with the htmx-indicator class on it to transition to an opacity of 1, showing the indicator.

<button hx-get="/click">
 Click Me!
 <img class="htmx-indicator" src="/spinner.gif">
</button>
Here we have a button. When it is clicked the htmx-request class will be added to it, which will reveal the spinner gif element. (I like SVG spinners these days.)

While the htmx-indicator class uses opacity to hide and show the progress indicator, if you would prefer another mechanism you can create your own CSS transition like so:

.htmx-indicator{
 display:none;
}
.htmx-request .my-indicator{
 display:inline;
}
.htmx-request.my-indicator{
 display:inline;
}
If you want the htmx-request class added to a different element, you can use the hx-indicator attribute with a CSS selector to do so:

<div>
 <button hx-get="/click" hx-indicator="#indicator">
 Click Me!
 </button>
 <img id="indicator" class="htmx-indicator" src="/spinner.gif"/>
</div>
Here we call out the indicator explicitly by id. Note that we could have placed the class on the parent div as well and had the same effect.

🔗Targets
If you want the response to be loaded into a different element other than the one that made the request, you can use the hx-target attribute, which takes a CSS selector. Looking back at our Live Search example:

<input type="text" name="q"
 hx-get="/trigger_delay"
 hx-trigger="keyup delay:500ms changed"
 hx-target="#search-results"
 placeholder="Search..."
>
<div id="search-results"></div>
You can see that the results from the search are going to be loaded into div#search-results, rather than into the input tag.

🔗Extended CSS Selectors
hx-target, and most attributes that take a CSS selector, support an “extended” CSS syntax:

You can use the this keyword, which indicates that the element that the hx-target attribute is on is the target
The closest <CSS selector> syntax will find the closest parent ancestor that matches the given CSS selector. (e.g. closest tr will target the closest table row to the element)
The next <CSS selector> syntax will find the next element in the DOM matching the given CSS selector.
The previous <CSS selector> syntax will find the previous element in the DOM the given CSS selector.
find <CSS selector> which will find the first child descendant element that matches the given CSS selector. (e.g find tr would target the first child descendant row to the element)
In addition, a CSS selector may be wrapped in < and /> characters, mimicking the query literal syntax of hyperscript.

Relative targets like this can be useful for creating flexible user interfaces without peppering your DOM with loads of id attributes.

🔗Swapping
htmx offers a few different ways to swap the HTML returned into the DOM. By default, the content replaces the innerHTML of the target element. You can modify this by using the hx-swap attribute with any of the following values:

Name	Description
innerHTML	the default, puts the content inside the target element
outerHTML	replaces the entire target element with the returned content
afterbegin	prepends the content before the first child inside the target
beforebegin	prepends the content before the target in the targets parent element
beforeend	appends the content after the last child inside the target
afterend	appends the content after the target in the targets parent element
delete	deletes the target element regardless of the response
none	does not append content from response (Out of Band Swaps and Response Headers will still be processed)
🔗Morph Swaps
In addition to the standard swap mechanisms above, htmx also supports morphing swaps, via extensions. Morphing swaps attempt to merge new content into the existing DOM, rather than simply replacing it, and often do a better job preserving things like focus, video state, etc. by preserving nodes in-place during the swap operation.

The following extensions are available for morph-style swaps:

Morphdom Swap - Based on the morphdom, the original DOM morphing library.
Alpine-morph - Based on the alpine morph plugin, plays well with alpine.js
Idiomorph - A newer morphing algorithm developed by us, the creators of htmx. Idiomorph will be available out of the box in htmx 2.0.
🔗View Transitions
The new, experimental View Transitions API gives developers a way to create an animated transition between different DOM states. It is still in active development and is not available in all browsers, but htmx provides a way to work with this new API that falls back to the non-transition mechanism if the API is not available in a given browser.

You can experiment with this new API using the following approaches:

Set the htmx.config.globalViewTransitions config variable to true to use transitions for all swaps
Use the transition:true option in the hx-swap attribute
If an element swap is going to be transitioned due to either of the above configurations, you may catch the htmx:beforeTransition event and call preventDefault() on it to cancel the transition.
View Transitions can be configured using CSS, as outlined in the Chrome documentation for the feature.

You can see a view transition example on the Animation Examples page.

🔗Synchronization
Often you want to coordinate the requests between two elements. For example, you may want a request from one element to supersede the request of another element, or to wait until the other elements request has finished.

htmx offers a hx-sync attribute to help you accomplish this.

Consider a race condition between a form submission and an individual input’s validation request in this HTML:

<form hx-post="/store">
 <input id="title" name="title" type="text"  hx-post="/validate"  hx-trigger="change"
 >
 <button type="submit">Submit</button>
</form>
Without using hx-sync, filling out the input and immediately submitting the form triggers two parallel requests to /validate and /store.

Using hx-sync="closest form:abort" on the input will watch for requests on the form and abort the input’s request if a form request is present or starts while the input request is in flight:

<form hx-post="/store">
 <input id="title" name="title" type="text"  hx-post="/validate"  hx-trigger="change"
 hx-sync="closest form:abort"
 >
 <button type="submit">Submit</button>
</form>
This resolves the synchronization between the two elements in a declarative way.

htmx also supports a programmatic way to cancel requests: you can send the htmx:abort event to an element to cancel any in-flight requests:

<button id="request-button" hx-post="/example">
 Issue Request
</button>
<button onclick="htmx.trigger('#request-button', 'htmx:abort')">
 Cancel Request
</button>
More examples and details can be found on the hx-sync attribute page.

🔗CSS Transitions
htmx makes it easy to use CSS Transitions without javascript. Consider this HTML content:

<div id="div1">Original Content</div>
Imagine this content is replaced by htmx via an ajax request with this new content:

<div id="div1" class="red">New Content</div>
Note two things:

The div has the same id in the original and in the new content
The red class has been added to the new content
Given this situation, we can write a CSS transition from the old state to the new state:

.red {
 color: red;
 transition: all ease-i