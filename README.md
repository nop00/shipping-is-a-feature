# Shipping is a feature ([pouet.net link](http://www.pouet.net/prod.php?which=57600))

This demo was [punkfloyd](http://www.punkfloyd.net)'s first production, released on PC Engine at [demodays](http://www.demodays.org) 2011.
You can build it using pceas by issuing the following command:
````
pceas demo.asm
````

You can then load the generated demo.pce into [mednafen](http://mednafen.sourceforge.net), your other emulator of choice, or even the real hardware :)


## History of the demo

I began fiddling with the console in early june 2011. After a few false starts and technical dead ends, I felt confident enough and let latortue, my partner in crime, convince me of releasing something for Demodays 2011, which is traditionally held on late august (deadline was august 27).
We were just past mid-july.

Hence the work began: we had no prior experience with the console, no tools, no musician, and barely a month and a half. I quickly coded some tools for myself, nothing really artist-friendly so latortue had to send me his pictures and have me process them before he could see them in the demo. The tools I wrote were abysmally slow when converting images to the PCE format, sometimes taking as much as 5 to 10 minutes for a 256x256 image (my laptop was also pretty old, but the tool was crap too). That's not really a problem when you're more than a month away from the party, but when you're at the party place, sweating like a drunk pig trying to beat the deadline, that becomes bloody annoying.

Anyway.

We began laying out a storyboard, and I continued working on various effects while latortue painted the first gfx. On august 7, 20 days before the deadline, I did my first commit directly related the demo, integrating some of latortue's art.  
At that point, I had begun crunching for a few days, going out of my usual 2*30 minutes commute routine to also code during my lunch break and at home after work as well. My wife was really supportive, bringing me food in front of the PC instead of whining because I wasn't dining with her (she probably knew I wouldn't let go anyway ;) ).  
On august 12, we had the two first screens in a pretty advanced state but absolutely nothing for the music. No lib, no tools ([DefleMask](http://delek.com.ar/deflemask) was not out at the time), and no musician (but I was kinda decided to do the music myself anyways).  
After a few days of fiddling with the sound without making anything usable, I decided it was time to go back to doing screens. After a pretty packed week-end (discovering that my code was filling more than one 8k memory bank was an unwelcomed surprise, although that made me figure out lots of stuff I didn't get before), we had all the screens in various states, going from barely-fleshed-out to finished. We also lowered our expectations and ditched a couple of screens so we could finish in time. We had one week ahead of us and still a lot of work to do.  
The screens came along nicely in the following week, and on friday morning I devoted my morning commute to trying to get some music in the demo. Much to my sadness, I went really badly, since playing music using the timer interrupt totally fucked up any affect based on the scanline interrupt. After work, I got to the train station to board my train to Zurich, filled with anxiety but still hopeful. I coded like a madman for 3 hours until my battery died, leaving me to contemplate the Swiss landscapes. Oh wait no, it was night time, all I could do was stare into the darkness while thinking about that f'ing music.  
After getting to the partyplace, greeting latortue and setting up, we grabbed a beer a discussed the demo. We had a bad experience the year before at [main](http://www.mainparty.net), where we epicly failed to deliver on the quick PC demo we drunkenly promised at a french scene pub meeting two weeks before the party. Doomed from the start as it was, we really put our best efforts into it, and it kind of broke my heart not to be able to release, so failing a second time after throwing even more time and passion at it was not an option.  
We considered releasing without music, since the screens were working, and though it felt wrong we agreed to keep this solution as a last resort.  
\[GENERIC PARTYING AND BEERING AND WORRYING AND SLEEPING\]  
Next morning is a blur, I guess I had a chocolate or something and went to work. The deadline was at 22:00, it was something like 10 or 11. So I did some tweaks on the greets, then moved on to the real problem: music. By 16:27 I had what I thought was a final version with music, but quickly discovered that some of the scanline interrupt-based effects were still fucked up. Angst ensued. After a few attempts to fix it, a desperate try at integrating some ripped game music (Air Zonk) which caused less problems but wasn't perfect, we decided to use our last option and release without music. So we added a quick warning screen that showed up at the start of the demo, saying this was a party version, so no sound + bugs are to be expected, and by 21:40 we had our final binaries ready for release.  
Releasing was a huge relief, most of the previous weeks' accumulated tension went away at once, and I suddenly realized I hadn't been eating since noon the previous day, hence the irrepressible shaking that began to take ahold of me. So I did what any reasonable scener would do: I went ouside with latortue and burned one out to celebrate :)  
Then I got beer and pizza, and started worrying if we would get disqualified because of the lack of music.  
Fast forward 2 hours, the compo started, and soon after the start was a C64 prod without music, looks like we were saved ! The audience even started whistling Tetris' music to compensate the lack of music, being the great guys that they are :)  
They had to start whistling again a few minutes later because we were next :)  
I still had doubts about releasing without any music, but boy was I wrong: seeing your prod on the big screen, even without sound, with the crowd cheering and yelling is a truly unique and uplifting experience, especially after all the trouble we went through to finish the demo.  
So, this unfinished production got us the fifth place, but I knew I had to make a final version with sound, and I was already at work when we returned to France with latortue on sunday. I fixed most of the remaining non-music bugs in the car, and then it took me two weeks to write and integrate the music. The music was done with MilkyTracker, then converted *by hand* to Azasel's text format.  

The version available here is the final one, with a little patch or two related to file paths that weren't working when building under linux.

Hope you enjoyed this little story, and good luck to you if you're reading the code ;)

