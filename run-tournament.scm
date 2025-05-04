(load "student1.scm")
(load "student2.scm")
(load "student3.scm")
(load "student4.scm")
(load "play-game.scm")

(define players
  (list
    (cons 'student1 choose-move-student1)
    (cons 'student2 choose-move-student2)
    (cons 'student3 choose-move-student3)
    (cons 'student4 choose-move-student4)))

(define (get-score board)
  (let ((p1 (list-ref board 6))
        (p2 (list-ref board 13)))
    (cond ((> p1 p2) '(1 0))
          ((< p1 p2) '(0 1))
          (else '(0.5 0.5)))))

(define (play-match p1 p2)
  (let* ((name1 (car p1)) (func1 (cdr p1))
         (name2 (car p2)) (func2 (cdr p2))
         (board (play-game func1 func2))
         (scores (get-score board)))
    (list name1 name2 scores)))

;; Immutable score update
(define (add-score scores name points)
  (define (update entries)
    (cond
      ((null? entries) (list (cons name points)))
      ((eq? (caar entries) name)
       (cons (cons name (+ (cdar entries) points)) (cdr entries)))
      (else
       (cons (car entries) (update (cdr entries))))))
  (update scores))

(define (update-scores scores match)
  (let ((p1 (car match))
        (p2 (cadr match))
        (s (caddr match)))
    (let ((s1 (car s)) (s2 (cadr s)))
      (add-score (add-score scores p1 s1) p2 s2))))

(define (run-tournament)
  (define (loop lst acc matches)
    (if (null? lst)
        (begin
          (for-each (lambda (m) (display m) (newline)) (reverse matches))
          (display "\n🏆 Final Scores:\n")
          (for-each (lambda (entry)
                      (display (car entry)) (display ": ")
                      (display (cdr entry)) (newline))
                    (sort acc (lambda (a b) (> (cdr a) (cdr b))))))
        (let ((head (car lst))
              (rest (cdr lst)))
          (let loop2 ((r rest) (scores acc) (ms matches))
            (if (null? r)
                (loop rest scores ms)
                (let ((match (play-match head (car r))))
                  (loop2 (cdr r)
                         (update-scores scores match)
                         (cons match ms))))))))
  (loop players '() '()))

(run-tournament)
