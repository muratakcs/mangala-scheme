(define (choose-move-student1 board player)
  ;; Soldan ilk dolu çukuru seçer
  (let ((range (if (= player 0) '(0 1 2 3 4 5)
                   '(7 8 9 10 11 12))))
    (car (filter (lambda (i) (> (list-ref board i) 0)) range))))
