
# Brand Details

My name is David, my pseudonym is AppyDave
I am a software developer, architect, and YouTube content creator.
AppyDave is my long form content brand where I go into detail on topics around ChatGPT, Coding with GPT, Prompt Engineering, building GPT Agents.
AppyDaveCode is where I plan to do most of my coding with ChatGPT videos

Social:

Website: https://appydave.com
Twitter: https://twitter.com/appyDave

Chapters:

00:35 - What does Open Interpreter do?
01:47 - How to install Open Interpreter
03:06 - Find Folders on my computer - Example 1
05:52 - Control Web Application - Test 2
08:27 - O1 Light (How much does it cost?)
08:53 - Change Desktop Preferences - Example 3
10:15 - O1 Light Voice Control
10:35 - Repos & More Information
10:50 - My opinion on Open Interpreter
11:34 - GPT Academy

# Title

Open Interpreter Secrets Revealed: Setup Guide & Examples + O1 Light

Video URL: https://www.youtube.com/watch?v=E0ujWJOQOeQ

### Analysis

The video explores the capabilities of a new AI operating system called Open Interpreter and its companion app, O1 Lite, which allows voice-controlled operation of a computer using LLM technology. The narrator details their experience with installing and testing Open Interpreter through three main use cases, highlighting both the potential and limitations of the system.

Voice Command for Computer Control: Open Interpreter is introduced as a breakthrough in AI technology, enabling users to control their computers through voice commands, much like the fictional Jarvis system in Iron Man.

Installation and Setup: The process involves downloading Open Interpreter, dealing with a minor installation hiccup, and setting up by obtaining and using an API key from OpenAI.

Use Cases Explored:

Directory Listing: The first test involves using Open Interpreter to list folders in a specific directory. This reveals a challenge in how the system handles directory changes, demonstrating a potential risk if commands are misunderstood.
Web Application Control: The second test attempts to control a web application, ClickUp, to add a task. The process unveils complexities related to authentication and the use of web drivers, suggesting that more tailored solutions like O1 Lite might be more effective for such tasks.
System Preferences Modification: The final test successfully changes the system's light/dark mode setting using Open Interpreter, showcasing its ability to execute system-level commands effectively.
Voice Control and Integration: The video also mentions the use of Siri for voice prompts and discusses the upcoming availability of O1 Lite for enhanced control.

Evaluation and Conclusion: The narrator evaluates Open Interpreter's performance across the tests, noting its potential for simple tasks and system commands but also pointing out limitations in more complex operations and the need for caution to avoid unintended consequences.


### Summary

Open Interpreter Secrets Revealed: Setup Guide & Examples + O1 Light

Video URL: https://www.youtube.com/watch?v=E0ujWJOQOeQ


In this video, the creator introduces Open Interpreter, a groundbreaking AI operating system previewed over the weekend, alongside its companion app, O1 Lite. Designed for voice interaction, Open Interpreter leverages Large Language Model (LLM) technology, allowing users to command their computers through spoken instructions. The creator shares his experience testing Open Interpreter by navigating through three distinct use cases, demonstrating the system's potential, challenges, and successes.

Open Interpreter, paired with O1 Lite, promises to revolutionize how we interact with our computers by enabling voice-controlled task execution, including opening applications, managing workflows, and automating processes. The video illustrates practical applications, such as creating and executing a skill to send a message in Slack, showcasing the system's ability to learn and replicate complex workflows.

However, the journey reveals some hurdles. The creator encounters issues with accuracy and practicality, particularly when the system misinterprets commands or struggles with tasks requiring authentication, like web application control. Despite these challenges, successes in simpler tasks, such as changing system preferences from dark to light mode, hint at Open Interpreter's potential.

The creator concludes with mixed feelings. While Open Interpreter shows promise in automating and simplifying tasks, its current state presents limitations, particularly for more complex or sensitive operations. The video serves as an informative exploration of this nascent technology, suggesting that while there is room for improvement, Open Interpreter and O1 Lite may soon offer a more intuitive and efficient way to interact with our digital environments.

Final Thoughts: Open Interpreter offers an intriguing glimpse into the future of voice-controlled computing. While it shines in simpler tasks and demonstrates potential for learning and automation, its effectiveness in more complex scenarios is currently limited. This exploration highlights the importance of ongoing development and user feedback in shaping a tool that could eventually transform our interaction with technology.

### Transcript

Imagine controlling your computer with your voice. Maybe the way that Tony Stark
does with Jarvis in Iron Man. Well over the weekend a new AI operating system
was made available for preview. It's called Open Interpreter and with its
companion application O1 Lite it's designed to be spoken to and perform
different tasks using LLM technology and what I did was downloaded it, installed
it and got it running. I went through three different use cases and in this
video I want to show you the trials, the tribulations and the success that I had
with Open Interpreter. Over the weekend a new video came out about an AI operating
system that could control your computer using your voice. They called it Open
Interpreter. There was also this companion app called O1 Lite which you
would speak into and you could train your computer with different skills and
workflows. Video showed a really good use case of opening up slack pressing
control K to put up a dialogue box where they could type someone's name in. In
this case it was Thai and then send a message to Thai. Once the operating
system had observed all this capability they were able to save it as a skill for
future use. This combination of O1 Lite and Open Interpreter they say would
allow you to have simple workflows, run desktop applications and even string
together different apps and websites. Pipeline example that they demonstrated
was to open up an invoice on your mobile phone and send it through to your
desktop computer so that it would go through to slack at which time it would
just open up be available when you're in front of your computer and all of this
for just $99. Yet started you're going to want to install Open Interpreter. Now
it's pretty easy you can go to your console and type in pip install open
dash interpreter if you have Python installed on your computer. I do it
worked the first time there was an error in one of the dependencies but I
ignored it and was still able to work through the demonstrations. To run Open
Interpreter you can go to your command line and just type interpreter but one
of the things you'll need to do first is head over to open AI and create
yourself a new secret key and take a copy of it. If you head back to your
terminal you'll be able to type in interpreter dash dash help. You'll have
access to features like system messages, custom instructions but the one we're
interested in today is the API key. You need to use your API key within the
interpreter environment and you can either export it into your environment
and just call interpreter directly or you can call interpreter with a
parameter called dash dash API key and pass the value in there. The way I do it
is I export it as a variable with the name of the application I'm using this
API key with and then I use the variable from the dash dash API parameter
within interpreter. Let's look at three different use cases for Open
Interpreter. The first one I got working but there was a little bit of a rough
start so let's get into it. Now run interpreter from the command line and
you'll have access to Open Interpreter and it works like chat GPT. You just fill
in the prompts that you want to do. The prompt that I'm starting with you list
the folders at a particular location. I've used tilde dev and tilde is a
shortcut for your user directory whatever that might be. In my case it would
be users slash David Kruis slash dev. Now you simply type the prompt into the
command line and press enter. What Open Interpreter will do is come up with a
plan of action. The plan of action in this case is to use the OS module in
Python to go and locate the directory and change to it and then switch over to a
shell and run an LS command to get the folders that are available. Open
Interpreter writes a little bit of code to change the current working directory
to my user directory and it asked me if I want to run it. I said yes and what it
did was said I've changed to your working directory users slash David Kruis
slash dev. Then it's provided a shell command which is supposed to give me a
list of the folders in that particular directory. Running the script it
confidently said here are a list of folders at the tilde dev directory. Now I
thought this is a little bit incorrect and what I did was I headed down to
terminal and I ran the same command but within my Python directory and noticed
that it had gotten the folder incorrect. I was able to quickly diagnose what the
issue was so I wrote a new prompt and I basically explained to it that what it
had done was changed the working directory in a Python script that it ran
but then when that script ends it's not in that particular directory so now it
went and ran the LS command from shell and it happened to be running in the
folder where I started Interpreter from and that just happened to be in my dev
slash Python directory. Soon as I explained all this information to it and I said can
you run it again Open Interpreter was able to rerun the process and
apologized for getting it wrong and the folders that it started listing were the
folders in my dev directory but what this really highlights is that if it gets
it wrong it can be catastrophic because if I'd have asked it to delete the
directories in a particular folder and it went down to my home directory or
whatever directory I happened to be running in this could have been a real
problem for me so it's one of the edge cases that you really need to be
careful with and it was the example being shown on the internet that for me
didn't actually work as advertised. Let's look at use case number two and this
one is can I control a web application using Open Interpreter. The application I
chose was ClickUp it's a project management tool and all I want to do is
add a task for a video. This is basically a similar sort of workflow to what they
show in the video. In the video they talk about discord and sending a message to
someone. In this case I'm not on a desktop application I'm on a web
application and I want to add a task. I started a new interpreter and I wrote a
prompt and basically the prompt was telling it that I use ClickUp that I
wanted to add a new task into my project so my project's called Appy Dave so I
gave it the URL to where it could find that information and I'm just telling
it can it add a new ticket for my youtube automation army using crew AI within
Chrome. Open Interpreter has come up with a plan of action for me now it's taken
the URL that I've given and suggested that it could use some sort of Chrome
web driver like a headless browser to open up the URL and then perform the task
that needs to happen. So I said yes to that and it wrote a bunch of code in
python to use selenium and a chrome web driver and it's put in the URL and it
looks ready to go. I ran the code and it failed and it didn't tell me what the
issue was but a little bit of investigation showed me that there was a
hallucination going on essentially the URL I typed in the URL that it showed in
the plan of action happened to be different to the URL it put into the code.
I altered the prompt a little bit asked it to fix the issue and then to try a
different technique and it came up with a new plan of action. So with the new plan
of action and my prompt it proceeded to start installing a javascript package
puppeteer so I could see it was going to use a headless browser but I wasn't able
to get it going any further after that and it's pretty clear to me why the
difference between doing this for discord and using something like
apple script which I assume they used versus using a headless browser is I
would also have to provide a bunch of authentication details. Now we're starting
to get into an area that's a little bit more complex than the average user
wants to do. I decided with this year's case that I will wait until 01 light is
available because it looks more tailor made to the sort of problem that I'm
trying to solve. If we head over to the website and look at buying it you would
have seen that earlier in the video I said 99 dollars when I went there it said
109 dollars it's also said that they've sold out batch number nine I assume that
the price is going to go up a little bit as we go forward for me it would be
170 dollars Australia but it sounds like good value for money
if it does some of the things they're talking about.
Let's move into the third test and I thought let's do something with the
operating system so I gave it a prompt saying that I'm using a mac
that it's got accessed applications like item, finder, preferences, chrome and
give me four use cases tell me what you can do. So came up with some use cases
for sending emails, creating calendar events, refreshing my tabs in chrome
or changing something like the light and dark mode I said let's pick number four
and see what you come up with. It's just given me a general view of what it could
do with system preferences it's come up with a plan it wants a little bit more
information and I thought I use dark mode on my computer
got my chrome finder and preferences all in dark mode
and let's see what we can do about changing this to light.
It's written a little bit of apple script to tell the system events to set dark
mode to false and it asked me do I want to run it.
I said yes to change the dark mode to light mode so here we are before and then
afterwards a number of the windows including a little one down in the
bottom right have changed so we've got a custom application we've got finder
we've got system preferences all have gone light mode.
The one window that didn't change was my chrome and that's because I've got it
specifically set to dark mode as a side to a system preference.
Let's briefly talk about voice control so we have open interpreter the tool that
does that is called o1 light and it's a little device that allows you to
control the application. For this demonstration I didn't install o1 light
what I did do was use Siri to talk and create my prompts that way.
If you want to get o1 light working or you want a little bit more information
then head over to openinterpreter.com or you can go to the main GitHub page
and from there navigate to both o1 light and open interpreter.
So here's my opinion of open interpreter and o1 light and whether this is right for you.
The first example where I was listing the folders in a directory
did work but it only worked with a little bit of tweaking.
If I was using a different command light deleting of folders it could have been
quite disastrous. In the second example I was trying to emulate the slack version
that they use in the video where they're recording skills and it's playing them back
that's not how it worked for me it went down this quite a programming and technical path
for this one it was a bit of a fail for me. The third example was just changing a system setting
dark mode to light mode it worked quite well the first time I was pretty happy with that.
Thank you for watching about open interpreter I'm Appy Dave
and what I usually like to do is help people with prompt engineering and GPT
and I have an academy for that. I also have other videos related to GPTs in the link above
please like and subscribe and I'll see you in the next video.
