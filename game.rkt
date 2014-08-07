(load "utils.rkt")
(load-all
 '(;core packages
   compat
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
   command-utils
   item
   weapon
   combat
   skill
   enemy-ai
   ;commands
   move-commands
   other-commands
   ;game data
   ;templates
   data/base-templates
   data/weapons
   data/items
   ;characters
   data/joe
   data/main-character
   data/bull
   data/gangsters
   data/boss-room
   ;maps   
   data/city
   ))

(print-lines
 "They said 2012 was the end of the world."
 "Maybe they were right."
 "The world has changed rapidly since then with the development of nano technology."
 "It feels like another world now."
 "...." 
 "You are heading back home after a long tiring day"
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

(display "\"Good, so your memory is still functioning, ")
(display character-name)
(display "\"")
(newline)
(ask joe 'talk '("I am Joe, in case you forget."))
(print-lines
 "(Welcome to LambdaRun)"
 "(Texts in parentheses are game tips)"
 "(Try talking to Joe. He might know what to do next)"
 "(To talk to a character, use ask/talk/@ <character name> <topic>)"
 "(Omit the topic for a general greeting)" 
 "(At any point in the game, you can access the ingame manual using the help command)"
 "(Have fun playing)")

(describe-room (ask main-character 'location))

(if (equal? character-name "demo")
    (set! command-queue
          '("take big-medkit"
            "snsd"
            "equip scythe"
            "attack Joe"
            "l memory-card"
            "take memory-card"
            "take laser-saber"
            "equip laser-saber"
            "l me"
            "n"
            "l Bull"
            "skills"
            "@ Bull implant"
            "attack Bull"
            "e"
            "n"
            "attack gangster2"
            "take blue-card"
            "n"
            "use big-medkit"
            "attack gangster1"
            "attack gangster2"
            "w"
            "take yellow-card"
            "e"
            "e"
            "attack gangster3"
            "take rainbow-card"
            "e"
            "l Ben"
            "attack Ben"
            "use memory-card server")))

(start-game-loop)