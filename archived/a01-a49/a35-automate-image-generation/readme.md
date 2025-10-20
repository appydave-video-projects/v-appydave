# Brand Details

My name is David, my pseudonym is AppyDave
I'm a YouTube content creator focused on ChatGPT, Prompt Engineering, GPT Agents, and Automation using ChatGPT.
My background is 35 years in software development and architecture, with a focus on innovative technology startups.
AppyCast is my long form content brand where I go into detail on topics around ChatGPT.
AppyDave is where I do my coding with ChatGPT videos.

Social:

Website: https://appydave.com
Twitter: https://twitter.com/appyDave


# Chapters

# Title

Automate MidJourney! Bulk Image Generation with This Script

Chapters:

00:00 - Bulk MidJourney Image Generation
00:15 - Story Board & Prompts
03:09 - Prepare Prompts
03:23 - Setup Automation
03:50 - Bulk MidJourney Script
07:10 - Get the script

## Abridgment - Summary

The video presents a guide on automating the generation of 20 images with MidJourney for a course, focusing on efficiency and consistency. The creator developed a script to automate the process, avoiding the manual task of individually inputting prompts. The project revolves around creating a cohesive storyboard of 10 scenes featuring a woman and her cat, ensuring visual consistency across the generated images. The creator emphasizes the importance of detailed descriptions in the image prompts to maintain the characters' appearances throughout the story.

To automate image generation, the creator crafted a script that formats the prompts, manages the generation sequence, and adheres to operational constraints like batch processing and pause intervals to accommodate MidJourney's limits. The process includes formatting prompts for MidJourney, using Discord for submissions, and setting specific intervals between submissions and pauses to efficiently manage the image generation process.

After running the automation script and generating the images, the creator reviews the results, noting some may need regeneration but overall achieving the desired outcome. The video concludes with a mention of further automation scripts for upscaling and organizing the generated images, encouraging viewers to explore more resources for automating image generation and management with MidJourney and ChatGPT.

## Abridgment - Analysis

The video outlines a method for automating the generation of 20 images using MidJourney for a course development project. The creator emphasizes the importance of efficiency in generating a series of consistent images without the need for manual input for each prompt. The process involves:

Creating a Storyboard: The creator proposes a storyline involving a woman and her cat, requiring a storyboard with 10 scenes. This storyboard is to ensure consistency in the visuals, especially focusing on the woman and her cat's appearance across all images.

Developing Image Prompts: The video suggests converting the storyboard scenes into image prompts suitable for MidJourney or DALL-E 3, emphasizing the need for detailed descriptions to maintain consistency in the characters' appearances across all generated images.

Automation Script: A significant part of the video details the creation and use of a script to automate the image generation process. This includes formatting the image prompts for automation, adjusting for specific image generation requirements (like ensuring character consistency), and managing the operational flow (e.g., how many images to generate in a batch, pause intervals).

Technical Details: The creator provides technical instructions on how to use the automation script, including command line options for specifying the prompts file, output file, intervals between image generations, and session management to accommodate MidJourney's operational limits.

Final Steps: After running the automation script and generating the images, the creator reviews the outcomes, noting the potential need for image regeneration if some do not meet expectations. The video also hints at further steps for upscaling and organizing the generated images, mentioning additional scripts available for automating these processes.

The video serves as a tutorial for streamlining the image generation process for creative projects, utilizing automation to save time and ensure consistency in visual storytelling elements.




## Transcript

I needed to generate 20 images in mid-journey for a course that I'm developing.
What I didn't want to do was feed the prompts in individually and wait around for an hour
or two for image generation.
So what I did was create a script to automate the process.
Let's start by creating 10 image prompts that are fairly consistent in nature.
I think what we could do is create a little story around a woman and her cat and then
generate 10 different image prompts that we can automate the image generation from.
I need to create a storyboard around a woman and her cat.
The storyboard needs to have 10 scenes in it.
We need to have really good visuals around the woman and the cat.
You can make them look however you want but I would like the description in each scene
to be of the same woman and of the same cat.
So now we have this cohesive storyboard of a woman and her cat and we'll just read the
first one morning routine.
The first slide of dawn filters through the curtains of a cozy bedroom casting a warm glow.
The woman in her late 20s with shoulder length curly hair and a serene smile is awakened by
the gentle purr of her sleek grey tabby cat nestled against her and then we've got breakfast
time working from home and basically 10 different scenes.
What we should do now is convert these into image prompts that we could use for mid-journey
or dali 3.
Can you create 10 image prompts for me please comma?
They should always reflect the same woman and the same cat so describing how they look
should be important but also the scene that they're in is also important.
Now it's generated 10 image prompts for us.
I've had a quick look through they're all pretty good and they'll be fine
for the demonstration of automation of image generation but one thing I do notice is that
the lady being 20s with shoulder curly length hair is not always repeated and so we may not
get the same image in this particular scene as we're expecting with the others.
So what I'll do is we'll just format this data a little bit differently so that we can use it
for our automation script and fix that one problem at the same time.
I need you to put each of these prompts into a code block one line per prompt comma.
I also need you to surround it with quote marks but not to include any other information
like the title or the actual prompt column.
I noticed in prompt number two that you did not describe the female in her 20s with curly hair.
Make sure that you describe both the cat and the lady in each prompt so that we get
a similar image for each picture that we're generating.
It started generating one line per prompt it's done it in quote marks and this is going to
be really easy for us to copy into our prompts text file which we will then feed into automation
routines. Now I've just opened a little file called prompts.txt and we'll just paste everything in.
I don't want the quote marks I'm just going to select them all
and delete them they shouldn't exist at the end or the beginning and we'll just save the file.
What we want to do is go through each prompt in our prompt file format it for mid journey
paste it into discord and hit return and then just wait for a period of time before repeating again.
Also every seven images in mid journey we want to wait for about three minutes before we start
again just to give it time to catch up with the image generation and we want to do that until
the end of the prompt file is finished. Now here is the script that will automate image
generation in mid journey. Now you can find a link in the description for this but in essence
what it does is it works from the command line and will accept a number of options.
So the first option being dash f is the prompts file and these are the prompts that we want to
read in and get generated automatically. The next option is the completed file and we would like
them as they go to end up in this location. You have to do things relatively slowly give time
between each image generation so what we've got is a default interval between pasting prompts
of four seconds and we only want to do seven prompts at a time in one session with mid journey.
Now this might depend on how fast the minutes are that you've got with mid journey if you're on
a basic plan you might even want to lower this down to four or five but then once that session
is finished you need to pause and I've got the pause here set for 180 seconds and the code is
all down here if you need help with that there's more information in the link in the description.
I've got my script ready to run I've given the output file as prompts complete mid journey which
will be this area here this is where the prompts are going to be read from and what we can do is
just start the script and I'll say starting mid journey it'll happen in 10 seconds make sure
that you open discord and just click into the little text spots there and in a moment it'll
start pasting the first prompt now after that happens it'll move that prompt down into the
completed section and just move on to prompt after prompt once it gets through seven of these prompts
it will then wait for 180 seconds before then finalizing the last three so far it's generated
seven images it's still pausing within the 180 seconds in a moment that will complete and then
we'll move on to the next three images being generated script having given enough time to
generate the last seven kicks in we're moving through the last three and in a moment this script
will finish and then we just need to wait for the final images to finish rendering on mid journey
it's been about 10 minutes working on this project and we've taken a script we've turned it into 10
different scenes we've turned them into prompts and then we've automated the image generation
within mid journey and our first image of our lady in her late 20s with dark brown curly hair
and a gray tabby cat in the kitchen is looking perfect as we move through some of the images
don't necessarily look great we might want to regenerate that one but generally these are
looking pretty perfect as we go through this is a really simple way of setting up story boards
and automating the process of image generation now the next step would be to upscale individual
images as we go and download them name them and put them into a folder i have scripts that
automate that as well so check out the link in the description about automating downloading of
mid journey and chat gpt images the script is available for access through the link in the
description it is part of a broader series of videos that i've done around automating chat gpt
using the open ai api i'm Appy dave hit like and subscribe if you want to learn more about using
chat gpt
