# ruby-volume
Ruby script to control system volume

IDK, I wrote this after switching desktop environments, again, late at night. For some reason, Cinnamon wasn't playing ball with Pulse, so my audio channels weren't unified. At the time of editing this README, I was tired, because I did this whole DE switch thing and new script overnight, and it's now like 8:30 AM.

I'm not sure if there're any errors, but it seems to work without any problems, so I'm not gonna bother going over it, right now.

Only change I'm 100% certain of, atm, that would help, is to *NOT* accept *ANY* non-numeric values, but users can also just like... follow the instructions...

You call it with the following syntax: ``ruby [path/to]/volume.rb`` and then the change in volume. It can be negative, positive, or a numeric value.

Examples:
1) ``ruby ~/Scripts/volume.rb -10`` --> decreases volume by 10%
1) ``ruby ~/Scripts/volume.rb +10`` --> increases volume by 10%
1) ``ruby ~/Scripts/volume.rb 10`` --> sets the volume *to* 10%
1) ``ruby ~/Scripts/volume.rb X`` --> sets the volume to 0% (mute), b/c the script defaults to 0%, and ``X`` is not a number or valid operator that will be parsed from the first character of my regex.

Enjoy! Hope it helps others who have this issue!
