(define dessert-pigeon
  (make-template
   "dessert-pigeon"
   (item '((hardness 6)))
   (weapon '((cost 5)
             (damage 20)
             (accuracy 70)))
   (description "A basic gun. Moderate accuracy. Moderate damage")))

(define johnson-gun
  (make-template
   "johnson-gun"
   (item '((hardness 10)))
   (weapon '((cost 20)
             (damage 20)
             (accuracy 30)))
   (description "It rains bullet. However, it is not very accurate.")))