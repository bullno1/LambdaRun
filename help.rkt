(define topics
  '((about ("Le Viet Bach"))
    ))

(register-command 
 '((names (help h ?))
   (args ())
   (vararg? #f))
 
 (lambda ()
   (print-lines
     "Available commands (alias in parenthesis):"
     " Movement"
     " (n)orth: Move north"
     " (s)outh: Move south"
     " (w)est: Move west"
     " (e)ast: Move east"
     ""
     " Interaction"
     " (eq)uip <item>: Equip an item in your inventory"
     " (l)ook [target]: Look at target or the surrounding if target is not given"
     " (u)se <item> [target]: Use an item on a target or yourself if target is not given"
     " (t)alk <character> [topic]: Talk to a character about a topic or greet them if topic is not given"
     " (sk)ill <skill> <target>: Use a skill on a target"
     " take <item>: Pick up an item"
     ""
     " Misc"
     " (i)nventory: Show your inventory"
     " (w)ait: Do nothing"
     " drop: Drop an item"
     " skills (sks): List your skills"
     " help: Show this menu")
   #f))