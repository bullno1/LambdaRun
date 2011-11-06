(define joe-talk
  (talker
   '((default ("What's up?"))
     (fallback ("No idea about that"))
     (hit ("You and I happened to discovered a very dirty *secret*."
           "They have to get rid of you."
           "Luckily, I found you in time and replaced your failed heart with an artificial implant."
           "Man, that thing costs a fortune. Don't get shot again."))
     (secret ("You really don't remember it?"
              "The evil plan of *NeoHydro*?"
              "I think you hit your head on the ground really hard when that guy got you"))
     (NeoHydro ("It's a bottled water and soft drink company, the biggest in the world."
                "It's famous for using *nanobot*s in water purification."
                "We accidentally discovered that those *nanobot*s are not just used in water purification."
                "We found a large amount of them in some NeoHydro's products."))
     (nanobot ("We have extracted the program of one of those *nanobot*s"
               "After reverse-engineering, it turns out that those *nanobot*s can take total control of your bodies"
               "They can alter metabolism, control the nervous system and various other stuffs that we have not discovered"
               "Basically, by drinking their water, you become a *remote-controlled* zombie. Their *remote-controlled* zombie."
               "I wonder if they have anything to do with recent *incidents*."))
     (incidents ("Do you read the news at all?"
                 "Bizzare incidents happened recently around the city."
                 "People started to commit heinous crimes that they usually would not dare to attempt."
                 "The strangest part is all of them doesn't seem to recall what they have done."))
     (remote-controlled ("We found some networking code in the program of those *nanobot*s."
                         "They seems to connect to a server."
                         "I tried to trace it and guess what? The server belongs to NeoHydro."
                         "I'm not sure what they are up to but it's definitely evil."
                         "We are both on their *hit* list due to our discovery."
                         "Based on what I gather from recent *incidents*. They may be able to control people so we can't reveal their plans"
                         "to the cops or the press."
                         "We are on our own now."
                         "Sorry if I talk to much. Let's get to *combat* trainning now"))
     (Ben ("If I'm not wrong, that's the CEO of *NeoHydro*"))
     (Scheme ("Now is the time for fighting, not coding"))
     (combat ("In a nutshell. Grab a *weapon*, attack your opponent until he dies. What aspects of it do you want to know more about?")))))

(define joe-desc  
  (long-description '("If your memory has not failed you, his name is Joe."
                      "You two worked together on a project."
                      "Then, you discovered a dirty *secret* that eventually led to a *hit* ordered on you."
                      ""
                      "  ,,,,,"
                      " |     |"
                      " |_   _|"
                      "(|  ^  |)"
                      " | -=- |"
                      "  \\___/"
                      "  |   |"
                      )))

(define joe-script
  ((lambda ()
     (define first-greet #t)
     (script
      "Joe-script"
      
      'enquire
      (lambda (self topic)
        (cond
          ((equal? topic "default")
           (if first-greet
               (begin
                 (ask joe 'talk '("We don't have much time to waste."
                                  "I know you have some basic *combat* training before."
                                  "But I still want you to go through the basics with me now."
                                  "Meet me at the backyard when you are ready to train."))
                 (newline)
                 (print-lines "(Did you notice some words in conversations are surrounded with an asterisk(*), like *this*?)"
                              "(Those are called keywords. Try talking to characters about those keywords. They usually give interesting answers)"
                              "(Of course, you are not restricted to just those keywords. Some characters know about lots of things)"
                              "(You can try asking Joe about that *hit* ordered on you)")
                 (ask joe 'move-to (ask (ask joe 'location) 'neighbor-towards 'south))
                 (set! first-greet #f))))
          
          ((equal? topic "combat")
           (combat-dialog))))
      
      'destroy
      (lambda (self)
        (ask bull
             'move-to 
             (cdr (assoc 'x0 city))))
      
      'on-attacked
      (lambda (self attacker)
        (if (eq? attacker main-character)
            (ask joe 'talk '("Oi! What are you doing?"))))
      ))))
   
   
(define joe
  (let ((joe (make-entity
              (extend-template
               character
               "Joe"
               (destructible
               '((max-hp 200)))
               joe-script
               joe-talk
               joe-desc)))
        (gun (make-entity johnson-gun))
        (picture
         (make-entity
          (make-template
           "picture-of-Bull"
           (item '((hardness 100)))
           (long-description '("Picture of the hacker you need to find"
                               ""
                               "  #####"
                               " #### _\\_"
                               " ##=-[.].]"
                               " #(    _\\ "
                               "  #   __| "
                               "   \\  _/  "
                               ".--'--'-. "))))))
    (ask gun 'give joe)
    (ask picture 'give joe)
    joe))
    
(define training-done #f)
(define (combat-dialog)
  (menu "Tell Joe:"
        '("Teach me the basics of combat"
          "Teach me about weapons"
          "Teach me about action cost"
          "Teach me about skills"                   
          "That's all I need to know")
        (lambda (choice)
          (case choice
            ((1)
             (ask joe 'talk '("First in order to engage in combat, you will nead a *weapon*"
                              "I'll give you one later."
                              "Pick it up with the take command"
                              "Then equip it using the equip command"
                              "To attack a target with the currently equipped weapon, use the attack command"                              
                              "You can learn more about commands from the game manual"
                              "What's a command you ask? It's what you type into that prompt"
                              "Yes, I'm breaking the fourth wall here, I know"))
             (combat-dialog))
            
            ((2)
             (ask joe 'talk '("There are 3 types of weapons melee, ranged and thrown"
                              "Melee weapons deal low damage if you are unskilled. However, it has low action cost."
                              "Ranged weapons are suitable for people of all level of skills"
                              "I mean just point your gun at your enemy, pull the trigger and then Bam!"
                              "He's gone. How hard is that right?"
                              "Actually to use firearms effectively, you need skills too"
                              "About thrown weapon, you can throw pretty much anything, however those with sharp edges like throwing knifes"
                              "or explosives will deal more damage"
                              "Thrown weapons don't need to be equipped. Just use the use command"))
             (combat-dialog))
            
            ((3)
             (ask joe 'talk '("That's how this game works"
                              "Every action has a cost attached to it"
                              "It is the number of turns you character will have to wait before performing the next action"))
             (combat-dialog))
            
            ((4)
             (ask joe 'talk '("Skills allow you to do special actions or grant you passive abilities"
                              "To perform an active skill, use the skill command"
                              "You can learn a skill from a teacher or do a cyber implant"))
             (combat-dialog))
            
            ((5)
             (if (not training-done)
                 (begin
                   (set! training-done #t)
                   (ask joe 'talk '("OK, let's begin *combat* training"
                                    "Take this gun and shoot the dummy"))
                   (ask (make-entity dessert-pigeon) 'drop (ask joe 'location))
                   (print-lines "Joe dropped a dessert-pigeon"
                                "Joe took out his phone, pressed something and a trainning dummy popped out from the ground")
                   (ask (make-entity
                         (make-template
                          "dummy"
                          (long-description '("A trainning dummy"
                                              ""
                                              "   O"
                                              "  /|\\"
                                              "  / \\"))
                          
                          (script
                           "dummy-script"
                           'destroy
                           (lambda (self)
                             (ask joe 'talk '("Good job! Now, here's the plan."
                                              "I have this memory card which contains a program that will destroy their *server*"
                                              "However, the *server* cannot be accessed remotely"
                                              "We will have to find the *server* and upload it directly"
                                              "It's not in *NeoHydra*'s headquarter though"))
                             (newline)
                             (print-lines "Suddenly, you hear a gunshot")
                             (newline)
                             (ask joe 'talk '("Sniper!! Take cover!! Find Bull, the hacker. He will know how to get to the *server*"))
                             (ask joe 'damage 9999999)                             
                             ))
                          
                          dweller
                          (destructible '((max-hp 40)))))
                        'move-to (ask joe 'location))
                   )))
            ))))