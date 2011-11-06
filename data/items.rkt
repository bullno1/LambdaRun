(define small-medkit
  (make-template
   "small-medkit"
   (item
    '((hardness 1)))
   (description "Recover 50 hp")
   (long-description '("     ________________"
                       "    /      ___      /|"
                       "   /   ___/  /__   / |"
                       "  /   /__   ___/  / /|"
                       " /      /__/     / / /"                       
                       "/_______________/ / /"
                       "|               |/ /"
                       "|    HP + 50    | /"
                       "|_______________|/"))
   (script
    "medkit"
    'use
    (lambda (self user target)
      (if (ask target 'find-component-by-name "destructible")
          (begin
            (ask user 'remove-item (ask self 'owner))
            (ask target 'heal 50)
            (display-multi (ask target 'name) "'s hp = " (ask target 'hp))
            (ask user 'add-rest-time 2)
            (ask target 'add-rest-time 2))
          (display-multi "You can't heal that"))))))

(define big-medkit
  (make-template
   "big-medkit"
   (item
    '((hardness 1)))
   (description "Fully recover hp")
   (long-description '("     ________________"
                       "    /      ___      /|"
                       "   /   ___/  /__   / |"
                       "  /   /__   ___/  / /|"
                       " /      /__/     / / /"                       
                       "/_______________/ / /"
                       "|               |/ /"
                       "|   HP -> MAX   | /"
                       "|_______________|/"))
   (script
    "medkit"
    'use
    (lambda (self user target)
      (if (ask target 'find-component-by-name "destructible")
          (begin
            (ask user 'remove-item (ask self 'owner))
            (ask target 'heal (ask target 'max-hp))
            (display-multi (ask target 'name) "'s hp = " (ask target 'hp))
            (ask user 'add-rest-time 3)
            (ask target 'add-rest-time 3))
          (display-multi "You can't heal that"))))))

(define memory-card
  (make-template
   "memory-card"
   (item '((hardness 1)))
   (description "Insert this into NeoHydra's server to destroy it")
   (long-description '("╔════════╗"
                       "║ MegaSD ║"
                       "╠════════╣"
                       "║ |||||| ║"                       
                       "╚════════╝"))
   (script
    "memory-card"
    'use
    (lambda (self user target)
      (if (eq? target server)
          (print-lines "You inserted the memory card into the server"
                       "The server blows up"
                       "NeoHydra's evil plan is thwarted"
                       "Congratulation, you've won"
                       "Secret code: snsd")
          (print-lines "You can't do that"))))))