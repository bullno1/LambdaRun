(define city-map
  '((__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __)
    (__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __)
    (__ __ __ __ __ __ __ __ sr __ __ __ __ __ __ __ __ __)
    (__ __ __ __ __ __ __ wc hr cr sv __ __ __ __ __ __ __)
    (__ __ __ __ __ __ __ __ ge __ __ __ __ __ __ __ __ __)
    (__ __ __ __ __ __ pk x0 lr __ __ __ __ __ __ __ __ __)
    (__ __ __ __ __ __ __ ho __ __ __ __ __ __ __ __ __ __)
    (__ __ __ __ __ __ __ by __ __ __ __ __ __ __ __ __ __)
    (__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __)
    (__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __)
    ))

(define (make-key-card name)
  (make-entity
   (make-template
    name
    (item '((hardness 1)))
    (description "Keep this in your inventory to go through a locked door")
    (long-description '("╔══════════════════════════╗"
                        "║        ACCESS CARD       ║"
                        "╠══════════════════════════╣"
                        "║                          ║"
                        "║    ││║║│║║║│││║║║║│║│    ║"
                        "║                          ║"
                        "║                          ║"
                        "╚══════════════════════════╝")))))
(define crate
  (make-template
   "crate"
   (item '((hardness 90)))
   (description "There should be goodies inside. Where's the crowbar when you  need it?")
   (long-description '("     ________________"
                       "    /               /|"
                       "   /               / |"
                       "  /               /  |"
                       " /               /   |"                       
                       "/_______________/    |"
                       "|               |    |"
                       "|      ***      |    |"
                       "|     *   *     |    |"
                       "|     *   *     |    /"
                       "|        *      |   /"
                       "|       *       |  /"
                       "|       .       | /"
                       "|_______________|/"))
   (destructible '((max-hp 50)))
   (carrier '())))
   
(define (locked-room name)
    (script
     "locked-script"
     'can-enter?
     (lambda (self entity)
       (ask (ask entity 'inventory) 'find
            (lambda (item)
              (not (not (equal? (ask item 'name) name))))))))

(define (dummy-room)
  (make-entity
   (make-template
    "dummy room"
    room)))

(define server-room null)
(define server null)

(define city 
  (make-area
   city-map

   ;long road
   'lr
   (let ((here (make-entity
                (make-template
                 "Long road"
                 room
                 (description "A long loooong road")
                 (long-description '("  ,-----,  /        /"
                                     "  | Long| /        /"
                                     "  |_____|/        /"
                                     "     ║  /        /"
                                     "     ║ /        /"
                                     "     ║/        /"
                                     "     /        /"
                                     "    /        /"
                                     "   /        /"))))))
     here)

   ;back yard
   'by
   (let ((here (make-entity
                (make-template
                 "Backyard"
                 room
                 (description "Pretty big for such a small house.")))))
     here)

   ;cross road
   'x0
   (let ((here (make-entity
                (make-template
                 "Crossroad"
                 room
                 (description "Not many people around")
                 (long-description '("           /        /"
                                     "          /        /"
                                     "________ /        /_____"
                                     ""
                                     "_______         _______"
                                     "      /        /"
                                     "     /        /"
                                     "    /        /"
                                     "   /        /"))
                                   ))))
     here)

   ;park
   'pk
   (make-entity
    (make-template
     "Park"
     room
     (description "The park is closed for maintainance")))
   
   ;gang hideout entrance
   'ge
   (let ((here (make-entity
                (make-template
                 "Hydra hideout entrance"
                 room
                 (description "Entrance to the headquarter of the Hydra's gang")
                 (long-description '("The main gate is locked. You need a key-card to enter"
                                     "║                          ║"
                                     "╠╧╧╧╧╧╧╧╧╧╧╧╧╤╧╧╧╧╧╧╧╧╧╧╧╧╧╣"
                                     "║            │             ║"
                                     "║   __       │             ║"
                                     "║  │__│      @             ║"
                                     "║            │             ║"
                                     "╚════════════╧═════════════╝")))))
         (guard (make-entity gangster2)))
     (ask guard 'move-to here)
     (ask (make-entity dessert-pigeon) 'give guard)
     (ask (make-key-card "blue-card") 'give guard)
     here)

   ;huge room
   'hr
   (let ((here (make-entity
                (make-template
                 "Huge room"
                 (locked-room "blue-card")
                 room
                 (description "A huge room")
                 (long-description '("The doors to the north and east require key-card")))))
          (gangster1 (make-entity gangster1))
          (gangster2 (make-entity gangster2)))
     
     (ask gangster1 'move-to here)
     (ask gangster2 'move-to here)
     (ask (make-entity dessert-pigeon) 'give gangster1)
     (ask (make-entity johnson-gun) 'give gangster2)
     (ask (make-entity small-medkit) 'drop here)
     here)

   ;toilet
   'wc
   (let ((here (make-entity
                (make-template
                 "Toilet"
                 room
                 (description "This place stinks"))))
         (yellow-card (make-key-card "yellow-card")))
     (ask yellow-card 'drop here)
     (ask yellow-card 'attach-component ((long-description '("This card is found lying on the toilet's floor"
                                                             "You wonder if it is really yellow or is it ..."))
                                         yellow-card))
     here)

   ;storage room
   'sr
   (let ((here (make-entity
                (make-template
                 "Storage room"
                 (locked-room "yellow-card")
                 room
                 (description "Lots of stuffs inside"))))
          (gangster1 (make-entity gangster1))
          (gangster2 (make-entity gangster2))
          (crate (make-entity crate)))
     
     (ask gangster1 'move-to here)
     (ask (make-entity johnson-gun) 'give gangster1)
     
     (ask gangster2 'move-to here)     
     (ask (make-entity johnson-gun) 'give gangster2)
     
     (ask (make-entity big-medkit) 'drop here)
     
     (ask crate 'drop here)     
     (ask (make-entity zombie-repellant) 'give crate)
     (loop 0 4
           (lambda (i)
             (ask (make-entity big-medkit) 'give crate)))
     here)

   ;corridor
   'cr
   (let ((here (make-entity
                (make-template
                 "Corridor"
                 room
                 (description "The server room is at the end of this corridor. The door to the server room is locked"))))
         (gangster1 (make-entity gangster1))
         (gangster2 (make-entity gangster2))
         (gangster3 (make-entity (extend-template gangster1 "gangster3")))
         (rainbow-card (make-key-card "rainbow-card")))
     (ask gangster1 'move-to here)
     (ask gangster2 'move-to here)
     (ask gangster3 'move-to here)
     (ask (make-entity dessert-pigeon) 'give gangster1)
     (ask (make-entity johnson-gun) 'give gangster2)
     (ask rainbow-card 'give gangster3)
     here)

   ;server room
   'sv
   (let* ((first-entrance #t)
          (here (make-entity
                 (make-template
                  "Server room"
                  (locked-room "rainbow-card")                  
                  room
                  (description "Finally, you have found it")
                  (script
                   "move-to-boss-room"
                   'add-entity
                   (lambda (self entity)
                     (if (and (eq? entity main-character)
                              first-entrance)
                         (begin
                           (set! first-entrance #f)
                           (perform-with-delay 1 
                                               (lambda ()
                                                 (print-lines "???: Not so fast!")
                                                 (ask main-character 'move-to boss-room)
                                                 (print-lines "You are teleported to another room")
                                                 (describe-room (ask main-character 'location)))))))))))
          (the-server (make-entity
                       (make-template
                        "server"
                        dweller
                        (description "The server that *nanobot* connects to. You need to destroy it.")))))
     
     (set! server-room here)     
     (set! server the-server)
     (ask server 'move-to here)
     here)

   ;home
   'ho
   (let ((here (make-entity
                (make-template
                 "Joe's house"
                 room
                 (description "It's small but cozy")                    
                 (long-description '("                ~~"
                                     "               ~~"
                                     "              ~~"
                                     "             | |   "
                                     "   __________|_|__ "
                                     "  /               \\ "                                     
                                     " |  __   ___   __  |  "
                                     " | |  | |   | |  | |  "
                                     " | |__| |   | |__| |  "
                                     " |______|___|______|  ")))))
         (crate (make-entity crate)))
     
     (ask main-character 'move-to here)
     (ask joe 'move-to here)     
     (ask crate 'drop here)
     (loop 0 5
           (lambda (i)
             (ask (make-entity small-medkit) 'give crate)))
     (ask (make-entity memory-card) 'give joe)
     here)
   ))