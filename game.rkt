(load "utils.rkt")
(load-all
 '(;core packages
   list
   oop
   entity   
   engine
   entity
   ;components
   room
   ticker
   actor
   map
   talker
   help
   menu
   carrier
   script
   dweller
   fighter
   destructible
   description
   ;commands
   move-commands
   other-commands
   ;game data
   data/base-templates
   data/city
   ))

(print-lines
 "They said 2012 was the end of the world."
 "Maybe they were right."
 "The world has changed rapidly since then with the development of nano technology."
 "It feels like another world now."
 "...." 
 "You are heading back to your dorm after a long tiring day in college"
 "Suddenly, BANG"
 "You feel something warm in your chest"
 "BLOOD!!"
 "Your vision fades away"
 "You collapsed"
 "...."
 "\"Hey wake up. You have slept for 3 days straight already!\""
 "\"Talk to me, dude! He only shot you in the heart, not in the head right?\""
 "\"Do you even remember your own name?\""
 "Enter your name and press enter")

(define character-name (prompt))

(prompt-and-execute-command)