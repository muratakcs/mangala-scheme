(load "student1.scm")
(load "student2.scm")
(load "student3.scm")
(load "play-game.scm")

;; Oyuncu isimlerini ve fonksiyonlarını eşleştiriyoruz
(define players
  (list
    (cons 'student1 choose-move-student1)
    (cons 'student2 choose-move-student2)
    (cons 'student3 choose-move-student3)))

;; Tahta durumuna göre skoru hesaplar: (1 0), (0 1), veya (0.5 0.5)
(define (get-score board)
  (let ((p1 (list-ref board 6))
        (p2 (list-ref board 13)))
    (cond ((> p1 p2) '(1 0))
          ((< p1 p2) '(0 1))
          (else '(0.5 0.5)))))

;; Tek bir eşleşmeyi çalıştır
(define (play-match p1 p2)
  (let* ((name1 (car p1)) (func1 (cdr p1))
         (name2 (car p2)) (func2 (cdr p2))
         (board (play-game func1 func2))
         (scores (get-score board)))
    (list name1 name2 scores)))

;; Her oyuncuyu kalanlarla eşleştir ve turnuva sonucu döndür
(define (run-tournament)
  (define (loop lst acc)
    (if (null? lst)
        acc
        (let ((head (car lst))
              (rest (cdr lst)))
          (let ((matches (map (lambda (opponent) (play-match head opponent)) rest)))
            (loop rest (append acc matches))))))
  (loop players '()))

(run-tournament)
