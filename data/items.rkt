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
            (ask target 'heal 20)
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