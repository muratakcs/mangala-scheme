(define (choose-move-student4 board player)
  (define range (if (= player 0) '(0 1 2 3 4 5) '(7 8 9 10 11 12)))
  (define valid-moves (filter (lambda (i) (> (list-ref board i) 0)) range))
  (list-ref valid-moves (random (length valid-moves))))
