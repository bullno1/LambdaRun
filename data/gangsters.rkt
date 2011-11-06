(define gangster1
  (extend-template
   character
   "gangster1"
   (description "A fierce gangster")
   (long-description '("  ,,,,,,"
                       "ლ(ಠ益ಠლ)"))      
   enemy-ai
   (talker '((default ("Die!!!"))
             (fallback ("Huh?"))))
   (destructible
    '((max-hp 100)))))

(define gangster2
  (extend-template
   gangster1
   "gangster2"
   (description "A scary gangster")
   (long-description '("  ||||||"
                       "ლ(ಠ益ಠლ)"))   
   (destructible
    '((max-hp 150)))))