 hypermedia-friendly approach to scripting in your htmx-based web application:

The primary integration point between htmx and scripting solutions is the events that htmx sends and can respond to. See the SortableJS example in the 3rd Party Javascript section for a good template for integrating a JavaScript library with htmx via events.

Scripting solutions that pair well with htmx include:

VanillaJS - Simply using the built-in abilities of JavaScript to hook in event handlers to respond to the events htmx emits can work very well for scripting. This is an extremely lightweight and increasingly popular approach.
AlpineJS - Alpine.js provides a rich set of tools for creating sophisticated front end scripts, including reactive programming support, while still remaining extremely lightweight. Alpine encourages the “inline scripting” approach that we feel pairs well with htmx.
jQuery - Despite its age and reputation in some circles, jQuery pairs very well with htmx, particularly in older code-bases that already have a lot of jQuery in them.
hyperscript - Hyperscript is an experimental front-end scripting language created by the same team that created htmx. It is designed to embed well in HTML and both respond to and create events, and pairs very well with htmx.
🔗The hx-on Attribute
HTML allows the embedding of inline scripts via the onevent properties, such as onClick:

<button onclick="alert('You clicked me!')">
 Click Me!
</button>
This feature allows scripting logic to be co-located with the HTML elements the logic applies to, giving good Locality of Behaviour (LoB). Unfortunately, HTML only allows on* attributes for a fixed number of specific DOM events (e.g. onclick) and doesn’t offer a way to respond generally to events in this embedded manner.

In order to address this shortcoming, htmx offers the hx-on attribute. This attribute allows you to respond to any event in a manner that preserves the LoB of the on* properties:

<button hx-on="click: alert('You clicked me!')">
 Click Me!
</button>
For a click event, we would recommend sticking with the standard onclick attribute. However, consider an htmx-powered button that wishes to add an attribute to a request using the htmx:configRequest event. This would not be possible with an on* property, but can be done using the hx-on attribute:

<button hx-post="/example"
 hx-on="htmx:beforeRequest: event.detail.parameters.example = 'Hello Scripting!'">
 Post Me!
</button>
Here the example parameter is added to the POST request before it is issued, with the value ‘Hello Scripting!’.

The hx-on attribute is a very simple mechanism for generalized embedded scripting. It is not a replacement for more fully developed front-end scripting solutions such as AlpineJS or hyperscript. It can, however, augment a VanillaJS-based approach to scripting in your htmx-powered application.

🔗hyperscript
Hyperscript is an experimental front end scripting language designed to be expressive and easily embeddable directly in HTML for handling custom events, etc. The language is inspired by HyperTalk, javascript, gosu and others.

You can explore the language more fully on its main website:

http://hyperscript.org

Hyperscript is not required when using htmx, anything you can do in hyperscript can be done in vanilla JS or with another javascript library like jQuery, but the two technologies were designed with one another in mind and play well together.

🔗Installing Hyperscript
To use hyperscript in combination with htmx, you need to install the hyperscript library either via a CDN or locally. See the hyperscript website for the latest version of the library.

When hyperscript is included, it will automatically integrate with htmx and begin processing all hyperscripts embedded in your HTML.

🔗Events & Hyperscript
Hyperscript was designed to help address features and functionality from intercooler.js that are not implemented in htmx directly, in a more flexible and open manner. One of its prime features is the ability to respond to arbitrary events on a DOM element, using the on syntax:

<div _="on htmx:afterSettle log 'Settled!'">
 ...
</div>
This will log Settled! to the console when the htmx:afterSettle event is triggered.

🔗intercooler.js features & hyperscript implementations
Below are some examples of intercooler features and the hyperscript equivalent.

Intercooler provided the ic-remove-after attribute for removing an element after a given amount of time.

In hyperscript you can implement this, as well as fade effect, like so:

<div _="on load wait 5s then transition opacity to 0 then remove me">
 Here is a temporary message!
</div>
🔗ic-post-errors-to
Intercooler provided the ic-post-errors-to attribute for posting errors that occured during requests and responses.

In hyperscript similar functionality is implemented like so:

<body _="on htmx:error(errorInfo) fetch /errors {method:'POST', body:{errorInfo:errorInfo} as JSON} ">
 ...
</body>
🔗ic-switch-class
Intercooler provided the ic-switch-class attribute, which let you switch a class between siblings.

In hyperscript you can implement similar functionality like so:

<div hx-target="#content" _="on htmx:beforeOnLoad take .active from .tabs for event.target">
 <a class="tabs active" hx-get="/tabl1" >Tab 1</a>
 <a class="tabs" hx-get="/tabl2">Tab 2</a>
 <a class="tabs" hx-get="/tabl3">Tab 3</a>
</div>
<div id="content">Tab 1 Content</div>
🔗3rd Party Javascript
Htmx integrates fairly well with third party libraries. If the library fires events on the DOM, you can use those events to trigger requests from htmx.

A good example of this is the SortableJS demo:

<form class="sortable" hx-post="/items" hx-trigger="end">
 <div class="htmx-indicator">Updating...</div>
 <div><input type='hidden' name='item' value='1'/>Item 1</div>
 <div><input type='hidden' name='item' value='2'/>Item 2</div>
 <div><input type='hidden' name='item' value='2'/>Item 3</div>
</form>
With Sortable, as with most javascript libraries, you need to initialize content at some point.

In jquery you might do this like so:

$(document).ready(function() {
 var sortables = document.body.querySelectorAll(".sortable");
 for (var i = 0; i < sortables.length; i++) {
 var sortable = sortables[i];
 new Sortable(sortable, {
 animation: 150,
 ghostClass: 'blue-background-class'
 });
 }
});
In htmx, you would instead use the htmx.onLoad function, and you would select only from the newly loaded content, rather than the entire document:

htmx.onLoad(function(content) {
 var sortables = content.querySelectorAll(".sortable");
 for (var i = 0; i < sortables.length; i++) {
 var sortable = sortables[i];
 new Sortable(sortable, {
 animation: 150,
 ghostClass: 'blue-background-class'
 });
 }
})
This will ensure that as new content is added to the DOM by htmx, sortable elements are properly initialized.

If javascript adds content to the DOM that has htmx attributes on it, you need to make sure that this content is initialized with the htmx.process() function.

For example, if you were to fetch some data and put it into a div using the fetch API, and that HTML had htmx attributes in it, you would need to add a call to htmx.process() like this:

let myDiv = document.getElementById('my-div')
fetch('http://example.com/movies.json')
 .then(response => response.text())
 .then(data => { myDiv.innerHTML = data; htmx.process(myDiv); } );
Some 3rd party libraries create content from HTML template elements. For instance, Alpine JS uses the x-if attribute on templates to add content conditionally. Such templates are not initially part of the DOM and, if they contain htmx attributes, will need a call to htmx.process() after they are loaded. The following example uses Alpine’s $watch function to look for a change of value that would trigger conditional content:

<div x-data="{show_new: false}"
 x-init="$watch('show_new', value => {
 if (show_new) {
 htmx.process(document.querySelector('#new_content'))
 }
 })">
 <button @click = "show_new