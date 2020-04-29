# Troubleshooting

Below I'll go into the deep of some issues you could be facing

- In the Hall of Fame I see an incorrect date
  - This appears to be a DOSBox issue. I've tried the same in several DOS applications, including WordPerfect 5.1, and they all come up with the same faulty date.
  
- Hall of Fame has not been saved
  - In the old DOS era, nearly all applications saved their stuff in the same folder as where the appliction itself was stored. Unix style home directories didn't exist in DOS back then. STARSHOOTER was written in DOS, and is therefore bound to the old DOS traditions in this. Therefore StarKill must be installed in a folder DOSBox has write access to in order to save the highscores
  
- Would the Source Code compile in FreePascal?
  - I haven't tried, and I'm not planning to. If you really want the game to compile in FreePascal feel free to fork the project and make the required modifications. As long as the GPL license is upheld.
  
- I get the message "Run-time error xxx in xxxx:xxxx". What gives?
  - Only possible if you triggered a bug. Report it to me, and note the three digit number in report. That number can give me an inidication what kind of error happened.
  
- "Run-Time error 200" 
  - If you get this error on start-up you found a really famous bug in Turbo Pascal itself. The game relies on the CRT unit and that unit is bugged. On most real DOS computers and in DOSBox it should normally not occur. It means the computer (or emulator) is too fast. If you can slow it down somehow the game might work.
  
  
  
