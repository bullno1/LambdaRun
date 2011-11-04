(define dessert-pigeon
  (make-template
   "dessert-pigeon"
   (item '((hardness 6)))
   (weapon '((cost 5)
             (damage 20)
             (accuracy 80)))
   (simple-weapon '((attack-count 1)))
   (description "A basic gun. Moderate accuracy. Moderate damage")
   (long-description '(" ,--^----------,--------,-----,-------^--,"
                       " | |||||||||   `--------'     |          O"
                       " `+---------------------------^----------|"
                       "  `\\_,-------, _________________________|"
                       "     / XXXXXX /`|     /"
                       "    / XXXXXX /  `\\  /"
                       "   / XXXXXX /\\______("
                       "  / XXXXXX /"
                       " / XXXXXX /"
                       "(________("
                       "`------'"))
   ))

(define johnson-gun
  (make-template
   "johnson-gun"
   (item '((hardness 10)))
   (weapon '((cost 2)
             (damage 20)
             (accuracy 40)))
   (simple-weapon '((attack-count 20)))
   (description "Created by Johnson, brother of Thompson. It rains bullet. However, it is not very accurate.")
   (long-description '("     OO                    QQQQ     OO"
                       "    OOOO                    QQ     OOOO"
                       "   WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"
                       "SSSXXXXXXXXXXXX--------XXXXXXXXXXXXXXXXXWmmmmmm"
                       "SSSXXXXXXXXXXXX--------XXXXXXWWWWWWWWWWWWMMMMMM"
                       "SSSXXXXXXXXXXXXxxxxxxxxXXXXXXWWWWWWWWWWWW"
                       "SSS   SSS     CEEEEEEEE C  Z"
                       "SSS SS        CWXXXXXXW  C Z"
                       "SSSS          CWXXXXXXWZZZZ"
                       "SSS            WXXXXXXW"
                       "SSS            WXXXXXXW"
                       "               WXX++XXW"
                       "                NNNNNN"
                       "                NNNNNN"))
   ))