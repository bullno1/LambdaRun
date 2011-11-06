(define bull-talk
  (talker
   '((default ("Yo!"))
     (fallback ("What?"))
     (NeoHydro ("Evil they are"
                "Stop them you must"
                "CEO of NeoHydro *Ben* is"))
     (Ben ("Powerful he is"
           "Final boss he may be"))
     (Joe ("Sad to hear that I am"
           "Destroy *NeoHydro*'s *server* you must"))
     (server ("It's in the hideout of Hydra, a criminal organization"
              "Security is tight"
              "You need to be *skill*ful to infiltrate"))
     (skill ("I can *implant* some skill chips into your brain"
             "Skill chips I currently have are:"
             "- headshot"
             "- rush"
             "- judo-throw"))
     (implant ("I implanted all the chip I have into your tiny brain"))
     (headshot ("This skill allows you to deals 200 damage to a target"
                "However, aiming takes a long long time"
                "Your enemies may get you before you manage to shoot them"))
     (rush ("This skill allows you to attack an enemy twice in a row"
            "The action cost is doubled, of course"))
     (judo-throw ("Throw your oponent on the ground, stunning him for a while")))))

(define bull-script
  (let ((implanted #f)
        (hostile #f)
        (first-time #t)
        (saber (make-entity laser-saber)))
    (script
     "bull-script"
     'post-initialize
     (lambda (self)
       (ask saber 'give (ask self 'owner)))
     
     'on-attacked
     (lambda (self attacker)
        (if (eq? attacker main-character)
            (set! hostile #t)))
     
     'act
     (lambda (self)
       (if (and (ask bull 'location) (ask saber 'location))
           (ask bull 'take-item saber)       
           (if (and hostile 
                    (eq? (ask main-character 'location) (ask bull 'location)))
               (cond
                 ((ask bull 'equipped-item)
                  (ask bull 'attack main-character))
             
                 ((and (eq? bull (ask saber 'holder)))
                  (ask bull 'equip saber)
                  (ask bull 'talk '("Die you will")))
                 ))))
     
     'destroy
     (lambda (self)
       (ask bull 'talk '("Nooooooooooooooooooo"
                       "I'm unbeatable!!!!!!")))
    
     'enquire
     (lambda (self topic)
       (cond
         ((equal? topic "implant")
          (if (not implanted)              
              (begin
                (ask bull 'talk '("OK, let's cut open your skull and implant these chips"
                                  "Wait a minute. What's that small gray blob inside your skull?"
                                  "Oh, that's your brain, I see"))
                (set! skill-set `((headshot ,headshot)
                                  (judo-throw ,judo-throw)
                                  (rush ,rush)))
                (set! implanted #t))))
         
         ((equal? topic "default")
          (begin                
            (if first-time
                (begin
                  (ask bull 'talk '("Originally, you are supposed to rescue me from a gang"
                                     "However, due to a lack of development time, I'm here"
                                     "Where's *Joe*?")))
                (set! first-time #f)))))))))
       
(define bull
  (let ((bull (make-entity
               (extend-template
                character
                "Bull"
                bull-talk
                bull-script
                (destructible '((max-hp 9999999)
                                (damage-threshold 10)))
                (long-description '("You sense a disturbance in the force"
                                    ""
                                    "  #####"
                                    " #### _\\_"
                                    " ##=-[.].]"
                                    " #(    _\\ "
                                    "  #   __| "
                                    "   \\  _/  "
                                    ".--'--'-. ")))))        
        )
    bull))