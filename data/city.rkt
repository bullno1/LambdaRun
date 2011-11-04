(define city-map
  '((__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __)
    (__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __)
    (__ __ __ __ __ __ __ __ __ l1 __ __ __ __ __ __ __ __)
    (__ __ __ __ __ __ __ __ wc g0 l0 __ __ __ __ __ __ __)
    (__ __ __ __ __ __ __ gy __ ge __ __ __ __ __ __ __ __)
    (__ __ __ __ __ __ pk x0 br da __ __ __ __ __ __ __ __)
    (__ __ __ __ __ __ __ ho __ ce __ __ __ __ __ __ __ __)
    (__ __ __ __ __ __ __ by __ __ __ __ __ __ __ __ __ __)
    (__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __)
    (__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __)    
    ))

(define (dummy-room)
  (make-entity
   (make-template
    "dummy room"
    room)))
  
(define city 
  (make-area
   city-map
   
   'da;dark alley
   (dummy-room)
   
   'br;bar
   (dummy-room)
   
   'by;back yard
   (let ((here (make-entity
                (make-template
                 "Backyard"
                 room
                 (description "Pretty big for such a small house.")))))
     here)
   
   'x0;cross road
   (let ((here (make-entity
                (make-template
                 "Crossroad"
                 room
                 (description "Not many people around")))))
     here)
   
   'gy;gym
   (dummy-room)
   
   'pk;park
   (dummy-room)
   
   'ge;gang hideout entrance
   (dummy-room)
   
   'g0;gang hideout room 0
   (dummy-room)
   
   'wc;toilet
   (dummy-room)
   
   'l0;locked room 0
   (dummy-room)
   
   'l1;locked room 1
   (dummy-room)
   
   'ce;corp entrance
   (dummy-room)
  
   'ho;home
   (let ((here (make-entity
                (make-template
                 "Joe's house"
                 room
                 (description "It's small but cozy"))))
         (gun (make-entity johnson-gun))
         (medkit (make-entity big-medkit)))
     (ask main-character 'move-to here)
     (ask joe 'move-to here)
     (ask gun 'give joe)
     (ask medkit 'drop here)
     here)
   ))