vents around validation that can be used to hook in custom validation and error handling:

htmx:validation:validate - called before an elements checkValidity() method is called. May be used to add in custom validation logic
htmx:validation:failed - called when checkValidity() returns false, indicating an invalid input
htmx:validation:halted - called when a request is not issued due to validation errors. Specific errors may be found in the event.detail.errors object
Non-form elements do not validate before they make requests by default, but you can enable validation by setting the hx-validate attribute to “true”.

🔗Validation Example
Here is an example of an input that uses the htmx:validation:validate event to require that an input have the value foo, using hyperscript:

<form hx-post="/test">
 <input _="on htmx:validation:validate
 if my.value != 'foo'
 call me.setCustomValidity('Please enter the value foo')
 else
 call me.setCustomValidity('')"
 name="example"
 >
</form>
Note that all client side validations must be re-done on the server side, as they can always be bypassed.

🔗Animations
Htmx allows you to use CSS transitions in many situations using only HTML and CSS.

Please see the Animation Guide for more details on the options available.

🔗Extensions
Htmx has an extension mechanism that allows you to customize the libraries’ behavior. Extensions are defined in javascript and then used via the hx-ext attribute:

<div hx-ext="debug">
 <button hx-post="/example">This button used the debug extension</button>
 <button hx-post="/example" hx-ext="ignore:debug">This button does not</button>
</div>
If you are interested in adding your own extension to htmx, please see the extension docs

🔗Included Extensions
Htmx includes some extensions that are tested against the htmx code base. Here are a few:

See the extensions page for a complete list.

🔗Events & Logging
Htmx has an extensive events mechanism, which doubles as the logging system.

If you want to register for a given htmx event you can use

document.body.addEventListener('htmx:load', function(evt) {
 myJavascriptLib.init(evt.detail.elt);
});
or, if you would prefer, you can use the following htmx helper:

htmx.on("htmx:load", function(evt) {
 myJavascriptLib.init(evt.detail.elt);
});
The htmx:load event is fired every time an element is loaded into the DOM by htmx, and is effectively the equivalent to the normal load event.

Some common uses for htmx events are:

🔗Initialize A 3rd Party Library With Events
Using the htmx:load event to initialize content is so common that htmx provides a helper function:

htmx.onLoad(function(target) {
 myJavascriptLib.init(target);
});
This does the same thing as the first example, but is a little cleaner.

🔗Configure a Request With Events
You can handle the htmx:configRequest event in order to modify an AJAX request before it is issued:

document.body.addEventListener('htmx:configRequest', function(evt) {
 evt.detail.parameters['auth_token'] = getAuthToken(); // add a new parameter into the request
 evt.detail.headers['Authentication-Token'] = getAuthToken(); // add a new header into the request
});
Here we add a parameter and header to the request before it is sent.

🔗Modifying Swapping Behavior With Events
You can handle the htmx:beforeSwap event in order to modify the swap behavior of htmx:

document.body.addEventListener('htmx:beforeSwap', function(evt) {
 if(evt.detail.xhr.status === 404){
 // alert the user when a 404 occurs (maybe use a nicer mechanism than alert())
 alert("Error: Could Not Find Resource");
 } else if(evt.detail.xhr.status === 422){
 // allow 422 responses to swap as we are using this as a signal that
 // a form was submitted with bad data and want to rerender with the
 // errors
 //
 // set isError to false to avoid error logging in console
 evt.detail.shouldSwap = true;
 evt.detail.isError = false;
 } else if(evt.detail.xhr.status === 418){
 // if the response code 418 (I'm a teapot) is returned, retarget the
 // content of the response to the element with the id `teapot`
 evt.detail.shouldSwap = true;  evt.detail.target = htmx.find("#teapot");
 }
});
Here we handle a few 400-level error response codes that would normally not do a swap in htmx.

🔗Event Naming
Note that all events are fired with two different names

So, for example, you can listen for htmx:afterSwap or for htmx:after-swap. This facilitates interoperability with other libraries. Alpine.js, for example, requires kebab case.

🔗Logging
If you set a logger at htmx.logger, every event will be logged. This can be very useful for troubleshooting:

htmx.logger = function(elt, event, data) {
 if(console) {
 console.log(event, elt, data);
 }
}
🔗Debugging
Declarative and event driven programming with htmx (or any other declartive language) can be a wonderful and highly productive activity, but one disadvantage when compared with imperative approaches is that it can be trickier to debug.

Figuring out why something isn’t happening, for example, can be difficult if you don’t know the tricks.

Well, here are the tricks:

The first debugging tool you can use is the htmx.logAll() method. This will log every event that htmx triggers and will allow you to see exactly what the library is doing.

htmx.logAll();
Of course, that won’t tell you why htmx isn’t doing something. You might also not know what events a DOM element is firing to use as a trigger. To address this, you can use the monitorEvents() method available in the browser console:

monitorEvents(htmx.find("#theElement"));
This will spit out all events that are occuring on the element with the id theElement to the console, and allow you to see exactly what is going on with it.

Note that this only works from the console, you cannot embed it in a script tag on your page.

Finally, push come shove, you might want to just debug htmx.js by loading up the unminimized version. It’s about 2500 lines of javascript, so not an insurmountable amount of code. You would most likely want to set a break point in the issueAjaxRequest() and handleAjaxResponse() methods to see what’s going on.

And always feel free to jump on the Discord if you need help.

🔗Creating Demos
Sometimes, in order to demonstrate a bug or clarify a usage, it is nice to be able to use a javascript snippet site like jsfiddle. To facilitate easy demo creation, htmx hosts a demo script site that will install:

htmx
hyperscript
a request mocking library
Simply add the following script tag to your demo/fiddle/whatever:

<script src="https://demo.htmx.org"></script>
This helper allows you to add mock responses by adding template tags with a url attribute to indicate which URL. The response for that url will be the innerHTML of the template, making it easy to construct mock responses. You can add a delay to the response with a delay attribute, which should be an integer indicating the number of milliseconds to delay

You may embed simple expressions in the template with the ${} syntax.

Note that this should only be used for demos and is in no way guaranteed to work for long periods of time as it will always be grabbing the latest versions htmx and hyperscript!

🔗Demo Example
Here is an example of the code in action:

<!-- load demo environment -->
<script src="https://demo.htmx.org"></script>

<!-- post to /foo -->
<button hx-post="/foo" hx-target="#result">
 Count Up
</button> <output id="result"></output>

<!-- respond to /foo with some dynamic content in a template tag -->
<script>
 globalInt = 0;
</script>
<template url="/foo" delay="500"> <!-- note the url and delay attributes -->
 ${globalInt++}
</template>

🔗Scripting
While htmx encourages a hypermedia-based approach to building web applications, it does not preclude scripting and offers a few mechanisms for integrating scripting into your web application. Scripting was explicitly included in the REST-ful description of the web architecture in the Code-On-Demand section. As much as is feasible, we recommend a