(define dessert-pigeon
  (make-template
   "dessert-pigeon"
   (item '((hardness 6)))
   (weapon '((cost 5)
             (damage 30)
             (accuracy 80)))
   (simple-weapon '((attack-count 1)))
   (description "A basic gun. Moderate accuracy. Moderate damage")
   (long-description '(" ,------------,---------,-------------^--,"
                       " |            `--------'                 |"
                       " `---------------------------------------|"
                       "  `\\_,--------,_________________________|"
                       "     /        /"
                       "    /        /"
                       "   /        /"
                       "  /        /"
                       " /        /"
                       "(________(" ))
   ))

(define johnson-gun
  (make-template
   "johnson-gun"
   (item '((hardness 10)))
   (weapon '((cost 2)
             (damage 20)
             (accuracy 40)))
   (simple-weapon '((attack-count 20)))
   (description "Created by Johnson, brother of Thompson. It sprays bullet. However, it is not very accurate.")
   (long-description '("         ___...-------------------|xxxx|----,==================,----^,"
                       ",,,,...'''                        |xxxx|    |  _____________   |     |"
                       "|          ,,-------------,----,-,|xxxx|----| (_____________)  |-----'"   
                       "|        ..               )   / ( |xxxx|    `------------------`"
                       "|    ..''                /   /    |xxxx|"
                       "|__''                   /   (     |xxxx|"
                       "                       |____(     |xxxx|"
                       "                                  |xxxx|"                       
                       "                                  '===='"
                       ))
   ))

(define zombie-repellant
  (make-template
   "zombie-repellant"
   (item '((hardness 10)))
   (weapon '((cost 10)
             (damage 110)
             (accuracy 90)))
   (simple-weapon '((attack-count 20)))
   (description "The perfect weapon for a zombie apocalypse. Relatively high damage. The only draw back is slow reload time")
   (long-description '("                        ____________________________________________#,"
                       "+===----....____,,...-''   [______] |________________________________|"
                       "|                      |____________|____,-----------------.___}" 
                       "|           ,--,  ,--'''   (_@_)         |__|||||||||||||__|"
                       "|     ,,,'''    \\/"
                       "| ,==="
                       "''"))
   ))

(define scythe
  (make-template
   "scythe"
   (item '((hardness 999999)))
   (weapon '((cost 1)
             (damage 999999999)
             (accuracy 9999999999)))
   (simple-weapon '((attack-count 1)))
   (description "Weapon of death")
   (long-description '("        _______   " 
                       "     _.'       \\  "
                       "   .`  _____    \\`"  
                       "  /__,`     `\\  \\"
                       " //           \\  \\ "
                       " V             \\  \\"
                       "                \\  \\"
                       "                 \\  \\"
                       "                  \\  \\"
                       "                   \\  \\"
                       "                    \\  \\"))))

(define laser-saber
  (make-template
   "laser-saber"
   (item '((hardness 999999)))
   (weapon '((cost 2)
             (damage 100)
             (accuracy 90)))
   (script
    "disarm"
    'use
    (lambda (self attacker target)      
      (let ((weapon (ask target 'equipped-item)))
        (if (and weapon 
                 (> (random 100) 50));50% chance of disarm
            (begin
              (ask target 'unequip)
              (ask target 'drop-item weapon))))))
   (simple-weapon '((attack-count 1)))
   (description "Isn't this item copyrighted?")
   (long-description '("  ||"
                       "  ||"
                       "  ||"
                       "  ||"
                       "  ||"
                       "  ||"
                       "  ||"
                       "  ||"
                       "  ||"
                       "  ||"
                       "  ||"
                       "  ||"
                       "  ##"
                       "  ##"
                       "  ##"
                       "  ##"
                       "  ``"))
   ))