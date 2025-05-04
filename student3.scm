(define (choose-move-student3 board player)
  ;; En çok taşa sahip olan çukuru seçer
  (let* ((range (if (= player 0) '(0 1 2 3 4 5)
                    '(7 8 9 10 11 12)))
         (pairs (map (lambda (i) (cons i (list-ref board i))) range))
         (sorted (sort pairs (lambda (a b) (> (cdr a) (cdr b))))))
    (car (car sorted))))
